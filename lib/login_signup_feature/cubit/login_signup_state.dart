part of 'login_signup_cubit.dart';

@immutable
abstract class LoginSignupState {}

class LoginSignupInitial extends LoginSignupState {}

class NavigateToSignupScreen extends LoginSignupState{}

class NavigateToLoginScreen extends LoginSignupState{}

class NavigateToWhere extends LoginSignupState{}

class PopBack extends LoginSignupState{}