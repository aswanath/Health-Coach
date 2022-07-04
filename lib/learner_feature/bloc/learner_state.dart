part of 'learner_bloc.dart';

enum Status {loading,success,fail,preLoading}
@immutable
abstract class LearnerState {}

class LearnerInitial extends LearnerState {}

class UnlockedCoursesState extends LearnerState{
  final Status status;
  final List<UnlockedCourses>? unlockedCourses;
  UnlockedCoursesState({required this.status,this.unlockedCourses});
}

class BannerState extends LearnerState{
  final Status status;
  final HomeBanner? banner;
  BannerState({required this.status,this.banner});
}

class LockedCoursesState extends LearnerState{
  final Status status;
  final List<LockedCourses>? lockedCourses;
  LockedCoursesState({required this.status,this.lockedCourses});
}


class LogOutState extends LearnerState{}

class CourseBuyState extends LearnerState{
  final Status status;
  CourseBuyState({required this.status});
}
