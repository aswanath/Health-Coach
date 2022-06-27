import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/learner_feature/home/model/banner_model.dart';
import 'package:health_coach/learner_feature/home/model/unlocked_course_model.dart';
import 'package:health_coach/repository/repository.dart';
import 'package:meta/meta.dart';

part 'learner_event.dart';

part 'learner_state.dart';

class LearnerBloc extends Bloc<LearnerEvent, LearnerState> {
  // final LoginSignupBloc loginSignupBloc;
  final Repository repository;
  late StreamSubscription _loginSignupSubscription;

  LearnerBloc({required this.repository}) : super(LearnerInitial()) {
    // _loginSignupSubscription = loginSignupBloc.stream.listen((state) {
    //   if(state is LoginSuccess){
    //     add(LoginRefresh());
    //   }
    // });

    on<LogOutEvent>((event, emit) async{
      await sharedPreferences.remove(tokenKey);
      await defaultCacheManager.emptyCache();
      await apiCacheManager.emptyCache();
      emit(LogOutState());
    });

    on<LoadBanner>((event, emit) async{
      emit(BannerState(status: Status.loading));
      try{
        final _banners = await repository.banner();
        emit(BannerState(status: Status.success,banner: _banners));
      }catch(e){
        emit(BannerState(status: Status.fail));
      }finally{
        add(LoadUnlockedCourses());
      }
    });

    on<LoadUnlockedCourses>((event, emit) async {
      emit(UnlockedCoursesLoading());
      try{
        final _courses = await repository.unlockedCourses();
        emit(UnlockedCoursesLoaded(unlockedCourses: _courses));
      }catch(e){
          emit(UnlockedCoursesLoadingFailed());
      }
    });
  }
}
