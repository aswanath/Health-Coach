import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/login_signup_feature/bloc/login_signup_bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial())  {
    final _userDetails = sharedPreferences.getString(tokenKey);
     Future.delayed(const Duration(milliseconds: 2400)).then((_) {
       if (_userDetails == null) {
          emit(SplashToSelection());
        } else {
         final _decodedUser = json.decode(_userDetails);
         if(_decodedUser["type"]==UserType.Learner.toString()) {
           emit(SplashToLearner());
         }else if(_decodedUser["type"]==UserType.Coach.toString()) {
           emit(SplashToCoach());
         }else if(_decodedUser["type"]==UserType.Admin.toString()) {
           emit(SplashToAdmin());
         }
       }
    });
  }
}
