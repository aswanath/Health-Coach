import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:health_coach/constants/api_constants.dart';
import 'package:health_coach/internet_connection/internet_bloc.dart';
import 'package:health_coach/login_signup_feature/login/model/login_post_model.dart';
import 'package:meta/meta.dart';

part 'login_signup_event.dart';

part 'login_signup_state.dart';

enum UserType { Coach, Learner, Admin }

final List<UserType> learnerLoginList = [UserType.Coach, UserType.Admin];
final List<UserType> coachLoginList = [UserType.Learner, UserType.Admin];
final List<UserType> adminLoginList = [UserType.Learner, UserType.Coach];

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  final Dio _dio = Dio();

  LoginSignupBloc()
      : super(TypeOfLogin(userType: UserType.Learner, list: learnerLoginList)) {

    on<NavigateToLogin>((event, emit) {
      emit(NavigateToLoginScreen());
    });

    on<NavigateToSignup>((event, emit) {
      emit(NavigateToSignUpScreen());
    });

    on<SelectLoginType>((event, emit) {
      List<UserType> userTypeList;
      if (event.userType == UserType.Learner) {
        userTypeList = learnerLoginList;
      } else if (event.userType == UserType.Coach) {
        userTypeList = coachLoginList;
      } else {
        userTypeList = adminLoginList;
      }
      emit(TypeOfLogin(userType: event.userType, list: userTypeList));
    });

    on<LoginUserCheck>((event, emit) async {
      emit(LoginChecking());
      final userCredentials =
          LoginPost(username: event.username, password: event.password);

      if (event.userType == UserType.Learner) {
        try {
          final check = await _dio.post(PostRequests.learnerLogin,
              data: loginPostToJson(userCredentials));
          if (check.statusCode == 200) {
            emit(LoginSuccess(userType: UserType.Learner));
          }
        } catch (e) {
          if (e is DioError) {
            if(e.type == DioErrorType.response){
                emit(LoginFailed(errorMessage: e.response!.data["message"]));
            }else{
              emit(LoginFailed(errorMessage: 'Something went wrong'));
            }
          }
        }
      }
    });
  }
}
