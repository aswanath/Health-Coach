part of 'login_signup_bloc.dart';

@immutable
abstract class LoginSignupEvent {}

class SelectLoginType extends LoginSignupEvent{
  final UserType userType;
  SelectLoginType({required this.userType});
}

class NavigateToLogin extends LoginSignupEvent{}

class NavigateToSignup extends LoginSignupEvent{}

class CoachAdminLearnerSelect extends LoginSignupEvent{}

class LoginUserCheck extends LoginSignupEvent{
  final String username;
  final String password;
  final UserType userType;
  LoginUserCheck({required this.password,required this.username,required this.userType});
}