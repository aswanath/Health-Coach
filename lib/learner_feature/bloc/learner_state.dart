part of 'learner_bloc.dart';

enum Status {loading,success,fail}
@immutable
abstract class LearnerState {}

class LearnerInitial extends LearnerState {}

class UnlockedCoursesState extends LearnerState{
  final Status status;
  final List<UnlockedCourses>? unlockedCourses;
  UnlockedCoursesState({required this.status,this.unlockedCourses});
}

class UnlockedCoursesLoading extends LearnerState{}

class UnlockedCoursesLoaded extends LearnerState{
  final List<UnlockedCourses> unlockedCourses;
  UnlockedCoursesLoaded({required this.unlockedCourses});
}

class UnlockedCoursesLoadingFailed extends LearnerState{}

class BannerState extends LearnerState{
  final Status status;
  final HomeBanner? banner;
  BannerState({required this.status,this.banner});
}

class LogOutState extends LearnerState{}
