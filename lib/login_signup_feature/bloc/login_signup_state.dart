part of 'login_signup_bloc.dart';

@immutable
abstract class LoginSignupState {}

class TypeOfLogin extends LoginSignupState {
  final UserType userType;
  final List<UserType> list;
  TypeOfLogin({required this.userType,required this.list});
}

class NavigateToLoginScreen extends LoginSignupState{}

class NavigateToSignUpScreen extends LoginSignupState{}

class LoginChecking extends LoginSignupState{}

class LoginSuccess extends LoginSignupState{
  final UserType userType;
  LoginSuccess({required this.userType});
}

class LoginFailed extends LoginSignupState{
  final String errorMessage;
  LoginFailed({required this.errorMessage});
}