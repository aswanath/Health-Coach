import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/login_signup_feature/signup_form/coach_form/model/signup_post_model.dart';
import 'package:health_coach/login_signup_feature/signup_form/learner_form/model/signup_post_model.dart';
import 'package:health_coach/repository/repository.dart';
import 'package:meta/meta.dart';

part 'login_signup_event.dart';

part 'login_signup_state.dart';

enum UserType { Coach, Learner, Admin }

final List<UserType> learnerLoginList = [UserType.Coach, UserType.Admin];
final List<UserType> coachLoginList = [UserType.Learner, UserType.Admin];
final List<UserType> adminLoginList = [UserType.Learner, UserType.Coach];

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  final Repository repository;

  //common fields
  String? name;
  String? userName;
  String? email;
  int? phone;
  String? password;
  String? imagePath = avatarList[3];
  bool? isGallery = false;

  //learner fields
  int? age;
  int? height;
  int? weight;
  String? healthCondition;

  //coach fields
  List<String>? certifications;
  List<String>? streams;
  String? about;

  LoginSignupBloc({required this.repository})
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
      try {
        await repository.login(
            username: event.username,
            password: event.password,
            userType: event.userType);
        emit(LoginSuccess(userType: event.userType));
      } catch (e) {
        emit(LoginFailed(errorMessage: e.toString()));
      }
    });

    on<FirstFormEvent>((event, emit) {
      name = event.name ?? name;
      userName = event.userName ?? userName;
      email = event.email ?? email;
      phone = event.phone ?? phone;
      password = event.password ?? password;
      imagePath = event.imagePath ?? imagePath;
      isGallery = event.isGallery ?? isGallery;
    });

    on<LearnerFormEvent>((event, emit) {
      age = event.age ?? age;
      height = event.height ?? height;
      weight = event.weight ?? weight;
      healthCondition = event.healthCondition ?? healthCondition;
    });

    on<CoachFormEvent>((event, emit) {
      certifications = event.certifications ?? certifications;
      streams = event.streams ?? streams;
      about = event.about ?? about;
    });

    on<LearnerRegisterCheck>((event, emit) async {
      emit(RegisterChecking());
      final userCredentials = LearnerRegisterPost(
          name: name!,
          username: userName!,
          email: email!,
          phone: phone!,
          password: password!,
          age: age!,
          height: height!,
          weight: weight!,
          healthcondition: healthCondition!);
      try {
        await emit.forEach(
            repository.learnerRegister(
                credentials: userCredentials,
                isGallery: isGallery!,
                imagePath: imagePath!),
            onData: (event) {
              if (event == 'registered') {
               return RegisterSuccess();
              } else if (event == 'logging') {
                return LoggingIn();
              } else{
                return LoginSuccess(userType: UserType.Learner);
              }
            });
        // repository
        //     .learnerRegister(
        //         credentials: userCredentials,
        //         isGallery: isGallery!,
        //         imagePath: imagePath!)
        //     .listen((event) {
        //   if (event == 'registered') {
        //     emit(RegisterSuccess());
        //   } else if (event == 'logging') {
        //     emit(LoggingIn());
        //   } else if (event == 'logged') {
        //     emit(LoginSuccess(userType: UserType.Learner));
        //   }
        // });
      } catch (e) {
        emit(RegisterFailed(errorMessage: e.toString()));
      }
    });

    on<CoachRegisterCheck>((event, emit) {
      emit(RegisterChecking());
      final userCredentials = CoachRegisterPost(
          name: name!,
          username: userName!,
          email: email!,
          phone: phone!,
          password: password!,
          streams: streams!,
          certifications: certifications!,
          about: about!);
    });
  }
}
