
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';


part 'login_signup_state.dart';

enum UserType{coach,learner,admin,invalid}

class LoginSignupCubit extends Cubit<LoginSignupState> with InputValidatorMixin{
  LoginSignupCubit() : super(LoginSignupInitial());

  void navigateSignup()=> emit(NavigateToSignupScreen());
  void navigateLogin()=>emit(NavigateToLoginScreen());
  void popBack()=>emit(PopBack());

  void navigateToWhere(GlobalKey<FormState> globalKey,String? val){
    if(globalKey.currentState!.validate()){
      final value = val!.trim();
      if(value == 'coach@gmail.com'){
        emit(UserTypeNavigation(userType: UserType.coach));
      }else if(value == 'learner@gmail.com'){
        emit(UserTypeNavigation(userType: UserType.learner));
      }else if(value == 'admin@gmail.com'){
        emit(UserTypeNavigation(userType: UserType.admin));
      }else{
        emit(UserTypeNavigation(userType: UserType.invalid));
      }
    }
  }
}
