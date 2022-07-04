part of 'learner_bloc.dart';

@immutable
abstract class LearnerEvent {}

class LogOutEvent extends LearnerEvent{}

class LoadLockedCourses extends LearnerEvent{
  final List<UnlockedCourses>? unlockedCourses;
  LoadLockedCourses({this.unlockedCourses});
}

class LoadUnlockedCourses extends LearnerEvent{}

class LoadBanner extends LearnerEvent{}

class HomeReloadEvent extends LearnerEvent{}

class CourseBuyEvent extends LearnerEvent{
  final LockedCourses lockedCourse;
  CourseBuyEvent({required this.lockedCourse});
}

