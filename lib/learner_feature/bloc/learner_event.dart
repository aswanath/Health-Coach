part of 'learner_bloc.dart';

@immutable
abstract class LearnerEvent {}

class LogOutEvent extends LearnerEvent{}

class LoadUnlockedCourses extends LearnerEvent{}

class LoadLockedCourses extends LearnerEvent{}

class LoadBanner extends LearnerEvent{}

