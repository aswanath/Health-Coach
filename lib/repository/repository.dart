import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:health_coach/constants/api_constants.dart';

import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/learner_feature/home/model/banner_model.dart';
import 'package:health_coach/learner_feature/home/model/unlocked_course_model.dart';
import 'package:health_coach/login_signup_feature/bloc/login_signup_bloc.dart';
import 'package:health_coach/login_signup_feature/login/model/login_post_model.dart';
import 'package:health_coach/login_signup_feature/login/model/login_response_model.dart';
import 'package:health_coach/login_signup_feature/signup_form/learner_form/model/signup_post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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

  Future<HomeBanner> banner()async {
    final _isCached = await apiCacheManager.isAPICacheKeyExist("API_banner");
    if (_isCached) {
      final _response  = await apiCacheManager.getCacheData("API_banner");
      final _decoded = await json.decode(_response.syncData);
      return HomeBanner.fromJson(_decoded);
    } else {
      try {
        final _response = await _dio.get(GetRequests.getHomeBanner);
        final _dbModel =  APICacheDBModel(key: "API_banner", syncData: json.encode(_response.data));
        await apiCacheManager.addCacheData(_dbModel);
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

  Future<List<UnlockedCourses>> unlockedCourses() async{
    final _isCached = await apiCacheManager.isAPICacheKeyExist("API_unlockedCourses");
    if(_isCached){
        final _response = await apiCacheManager.getCacheData("API_unlockedCourses");
        final _decode = await json.decode(_response.syncData);
        return unlockedCourseFromJson(_decode);
    }else {
      try {
        final _response = await _dio.get(
            GetRequests.getUserUnlockedCourses + id);
        final _modelClass = unlockedCourseFromJson(_response.data);
        List<UnlockedCourses> _filteredList = [];
        for (int i = 0; i < _modelClass.length; i++) {
          int count = 0;
          if(i==0){
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
        final _dbModel =   APICacheDBModel(key: "API_unlockedCourses", syncData: _filteredRaw);
        await apiCacheManager.addCacheData(_dbModel);
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

  // Future<List<LockedCourses>> lockedCourses() async{
  //
  // }
}

class ImageUtils {
  static Future<FormData> imageToFile(
      {required String imageName, required String fileName}) async {
    var bytes = await rootBundle.load(imageName);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return formDataGenerator(filePath: file.path, fileName: fileName);
  }

  static Future<FormData> formDataGenerator(
      {required String filePath, required String fileName}) async {
    FormData formData = FormData.fromMap(
        {"photo": await MultipartFile.fromFile(filePath, filename: fileName)});
    return formData;
  }
}
