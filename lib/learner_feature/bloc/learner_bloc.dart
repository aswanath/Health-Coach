import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/learner_feature/home/model/banner_model.dart';
import 'package:health_coach/learner_feature/home/model/locked_courses_model.dart';
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

    on<HomeReloadEvent>((event, emit) async{
      await apiCacheManager.deleteCache("API_banner");
      await apiCacheManager.deleteCache("API_unlockedCourses");
      await apiCacheManager.deleteCache("API_lockedCourses");
      add(LoadBanner());
    });

    on<CourseBuyEvent>((event, emit) async{
      emit(CourseBuyState(status: Status.preLoading));
       try{
         final _futureStatus = await repository.buyCourse(event.lockedCourse);
         final _status = await _futureStatus;
         emit(CourseBuyState(status: _status));
       }catch(e){
         emit(CourseBuyState(status: Status.fail));
       }
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
      emit(UnlockedCoursesState(status: Status.loading));
      List<UnlockedCourses> _courses = [];
      try{
         _courses = await repository.unlockedCourses();
        emit(UnlockedCoursesState(status: Status.success,unlockedCourses: _courses));
      }catch(e){
          emit(UnlockedCoursesState(status: Status.fail));
      }finally{
        add(LoadLockedCourses(unlockedCourses: _courses));
      }
    });

    on<LoadLockedCourses>((event, emit) async{
      emit(LockedCoursesState(status: Status.loading));
      List<LockedCourses> _courses = [];
      try{
       _courses = await repository.lockedCourses(unlockedList: event.unlockedCourses);
       emit(LockedCoursesState(status: Status.success,lockedCourses: _courses));
      }catch (e){
         emit(LockedCoursesState(status: Status.fail));
      }
    });
  }
}
