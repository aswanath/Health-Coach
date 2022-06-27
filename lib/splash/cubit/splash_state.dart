part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashToSelection extends SplashState{}

class SplashToLearner extends SplashState{}

class SplashToCoach extends SplashState{}

class SplashToAdmin extends SplashState{}
