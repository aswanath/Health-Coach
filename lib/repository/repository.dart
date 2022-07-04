import 'dart:async';
import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart';
import 'package:health_coach/constants/api_constants.dart';

import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_classes/image_utils.dart';
import 'package:health_coach/learner_feature/bloc/learner_bloc.dart';
import 'package:health_coach/learner_feature/home/model/banner_model.dart';
import 'package:health_coach/learner_feature/home/model/buy_course_model.dart';
import 'package:health_coach/learner_feature/home/model/locked_courses_model.dart';
import 'package:health_coach/learner_feature/home/model/unlocked_course_model.dart';
import 'package:health_coach/learner_feature/home/model/user_details_model.dart';
import 'package:health_coach/login_signup_feature/bloc/login_signup_bloc.dart';
import 'package:health_coach/login_signup_feature/login/model/login_post_model.dart';
import 'package:health_coach/login_signup_feature/login/model/login_response_model.dart';
import 'package:health_coach/login_signup_feature/signup_form/learner_form/model/signup_post_model.dart';
import 'package:path/path.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Repository {
  final Dio _dio = Dio();

  dynamic _userAllDetails = sharedPreferences.getString(tokenKey) != null
      ? json.decode(sharedPreferences.getString(tokenKey)!)
      : null;

  String get name => _userAllDetails["name"];

  String get id => _userAllDetails["id"];

  String get token => _userAllDetails["token"];

  String get image => _userAllDetails["image"];

  String get type => _userAllDetails["type"];

  Future<HomeBanner> banner() async {
    final _isCached = await apiCacheManager.isAPICacheKeyExist("API_banner");
    if (_isCached) {
      final _response = await apiCacheManager.getCacheData("API_banner");
      final _decoded = await json.decode(_response.syncData);
      return HomeBanner.fromJson(_decoded);
    } else {
      try {
        final _response = await _dio.get(GetRequests.getHomeBanner);
        await addToCache(key: "API_banner", syncData: json.encode(_response.data));
        return HomeBanner.fromJson(_response.data);
      } catch (e) {
        if (e is DioError) {
          if (e.type == DioErrorType.response) {
            throw e.response!.data["message"];
          } else {
            throw "Something went wrong";
          }
        } else {
          throw "Something went wrong";
        }
      }
    }
  }

  Future<void> login(
      {required String username,
      required String password,
      required UserType userType}) async {
    String _loginLink;
    if (userType == UserType.Learner) {
      _loginLink = PostRequests.postLearnerLogin;
    } else if (userType == UserType.Coach) {
      _loginLink = PostRequests.postCoachLogin;
    } else {
      _loginLink = PostRequests.postAdminLogin;
    }
    final _userCredentials = LoginPost(username: username, password: password);

    if (userType == UserType.Admin) {
    } else {
      try {
        final _check = await _dio.post(_loginLink,
            data: loginPostToJson(_userCredentials));
        final _user = LoginResponse.fromJson(_check.data);
        final _userDetails = {
          "id": _user.id,
          "token": _user.token,
          "type": UserType.Learner.toString(),
          "name": _user.name,
          "image": _user.profilephoto
        };
        await sharedPreferences.setString(tokenKey, json.encode(_userDetails));
        _userAllDetails = json.decode(sharedPreferences.getString(tokenKey)!);
        _dio.options.headers['Authorization'] = 'Bearer ' + _user.token;
      } catch (e) {
        if (e is DioError) {
          if (e.type == DioErrorType.response) {
            throw e.response!.data["message"];
          } else {
            throw "Something went wrong";
          }
        }
      }
    }
  }

  Stream<String> learnerRegister(
      {required LearnerRegisterPost credentials,
      required bool isGallery,
      required String imagePath}) async* {
    try {
      final _response = await _dio.post(PostRequests.postLearnerRegister,
          data: learnerRegisterPostToJson(credentials));
      yield "registered";
      await Future.delayed(const Duration(milliseconds: 1000));
      yield "logging";
      _dio.options.headers['Authorization'] =
          'Bearer ' + _response.data["token"];
      await Future.delayed(const Duration(milliseconds: 1000));
      FormData? _formData;
      if (isGallery) {
        _formData = await ImageUtils.formDataGenerator(
            filePath: imagePath, fileName: basename(imagePath));
      } else {
        _formData = await ImageUtils.imageToFile(
            imageName: imagePath, fileName: basename(imagePath));
      }
      final _patchResponse =
          await _dio.patch(PatchRequests.patchImageUpload, data: _formData);
      final _updatedUser = LoginResponse.fromJson(_patchResponse.data);
      final _userDetails = {
        "id": _updatedUser.id,
        "token": _updatedUser.token,
        "type": UserType.Learner.toString(),
        "name": _updatedUser.name,
        "image": _updatedUser.profilephoto
      };
      await sharedPreferences.setString(tokenKey, json.encode(_userDetails));
      _userAllDetails = json.decode(sharedPreferences.getString(tokenKey)!);
      yield "logged";
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          throw e.response!.data["message"];
        } else {
          throw 'Something went wrong';
        }
      }
    }
  }

  Future<List<UnlockedCourses>> unlockedCourses() async {
    final _isCached =
        await apiCacheManager.isAPICacheKeyExist("API_unlockedCourses");
    if (_isCached) {
      final _response =
          await apiCacheManager.getCacheData("API_unlockedCourses");
      final _decode = await json.decode(_response.syncData);
      return unlockedCourseFromJson(_decode);
    } else {
      try {
        final _response =
            await _dio.get(GetRequests.getUserUnlockedCourses + id);
        final _modelClass = unlockedCourseFromJson(_response.data);
        List<UnlockedCourses> _filteredList = [];
        for (int i = 0; i < _modelClass.length; i++) {
          int count = 0;
          if (i == 0) {
            _filteredList.add(_modelClass[0]);
          }
          for (int j = 0; j < _filteredList.length; j++) {
            if (_modelClass[i].workout.id == _filteredList[j].workout.id) {
              count = 1;
              break;
            }
          }
          if (count == 0) {
            _filteredList.add(_modelClass[i]);
          }
        }
        final _filteredRaw = unlockedCourseToJson(_filteredList);
        await addToCache(key: "API_unlockedCourses", syncData: _filteredRaw);
        return _filteredList;
      } catch (e) {
        if (e is DioError) {
          if (e.type == DioErrorType.response) {
            throw e.response!.data["message"];
          } else {
            throw "Something went wrong";
          }
        } else {
          throw "Something went wrong";
        }
      }
    }
  }

  Future<List<LockedCourses>> lockedCourses(
      {List<UnlockedCourses>? unlockedList}) async {
    final _isCached =
        await apiCacheManager.isAPICacheKeyExist("API_lockedCourses");
    if (_isCached) {
      final _response = await apiCacheManager.getCacheData("API_lockedCourses");
      final _decode = await json.decode(_response.syncData);
      return lockedCoursesFromJson(_decode);
    } else {
      try {
        final _response = await _dio.get(GetRequests.getAllCourses);
        final _modelClass = lockedCoursesFromJson(_response.data);
        List<LockedCourses> _filteredList = [];
        unlockedList ??= await unlockedCourses();
        for (int i = 0; i < _modelClass.length; i++) {
          int count = 0;
          for (int j = 0; j < unlockedList.length; j++) {
            if (_modelClass[i].id == unlockedList[j].workout.id) {
              count = 1;
              break;
            }
          }
          if (count == 0) {
            _filteredList.add(_modelClass[i]);
          }
        }

        final _filteredRaw = lockedCoursesToJson(_filteredList);
        await addToCache(key: "API_lockedCourses", syncData: _filteredRaw);
        return _filteredList;
      } catch (e) {
        if (e is DioError) {
          if (e.type == DioErrorType.response) {
            throw e.response!.data["message"];
          } else {
            throw "Something went wrong";
          }
        } else {
          throw "Something went wrong";
        }
      }
    }
  }

  Future<Future> buyCourse(LockedCourses lockedCourse) async {
    final Razorpay _razorpay = Razorpay();
    final Dio _newDio = Dio();
    final Completer _completer = Completer();
    _newDio.options.headers['Authorization'] =
        'Basic ' + Keys.baseAuthorizationToken;

    try {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) async {
        await _paymentSuccess(
            paymentSuccessResponse: response, lockedCourse: lockedCourse);
        _completer.complete(Status.success);
      });
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        if (response.code == 2) {
          _completer.complete(Status.loading);
        } else {
          _completer.complete(Status.fail);
        }
      });
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) async {
        await _paymentSuccess(
            externalWalletResponse: response, lockedCourse: lockedCourse);
        _completer.complete(Status.success);
      });

      final _userDetail = await userDetail();
      final _data = {
        "amount": num.parse(lockedCourse.price) * 100,
        "currency": "INR"
      };
      final _response =
          await _newDio.post(PostRequests.postOrderIdGenerator, data: _data);
      var options = {
        'key': Keys.keyId,
        'amount': _response.data["amount"],
        'name': 'Health Coach',
        'order_id': _response.data["id"],
        'description': lockedCourse.workout,
        'timeout': 300, // in seconds
        'prefill': {'contact': _userDetail.phone, 'email': _userDetail.email}
      };
      _razorpay.open(options);
      return _completer.future;
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          throw e.response!.data["message"];
        } else {
          throw "Something went wrong";
        }
      } else {
        throw "Something went wrong";
      }
    }
  }

  Future<UserDetails> userDetail() async {
    try {
      final _response = await _dio.get(GetRequests.getUserDetails + id);
      return userDetailsFromJson(json.encode(_response.data));
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          throw e.response!.data["message"];
        } else {
          throw "Something went wrong";
        }
      } else {
        throw "Something went wrong";
      }
    }
  }

  Future<void> _paymentSuccess(
      {PaymentSuccessResponse? paymentSuccessResponse,
      ExternalWalletResponse? externalWalletResponse,
      required LockedCourses lockedCourse}) async {
    final _paymentDetails = Paymentdetails(
        paymentMethodData: PaymentMethodData(
            description: "Razorpay",
            type: "Online",
            info: paymentSuccessResponse != null
                ? paymentSuccessResponse.orderId!
                : externalWalletResponse!.walletName!));
    final _model =
        BuyCourseModel(paymentdetails: _paymentDetails, item: lockedCourse);
    final _body = buyCourseModelToJson(_model);
    _dio.options.headers['Authorization'] = 'Bearer ' + token;
    await _dio.post(PostRequests.postBuyCourse, data: _body);
  }

  Future<void> addToCache(
      {required String key, required String syncData}) async {
    final _dbModel = APICacheDBModel(key: key, syncData: syncData);
    await apiCacheManager.addCacheData(_dbModel);
  }
}


