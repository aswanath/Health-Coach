
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'login_signup_state.dart';

class LoginSignupCubit extends Cubit<LoginSignupState> {
  LoginSignupCubit() : super(LoginSignupInitial());

  void navigateSignup()=> emit(NavigateToSignupScreen());
  void navigateLogin()=>emit(NavigateToLoginScreen());
  void popBack()=>emit(PopBack());

  void navigateToWhere(GlobalKey<FormState> globalKey){
    if(globalKey.currentState!.validate()){
      emit(NavigateToWhere());
    }
  }
}
