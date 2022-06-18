part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class ChangeIndexEvent extends NavigationEvent{
  final int index;
  final bool isCoach;
  ChangeIndexEvent({required this.index,required this.isCoach});
}

class CourseCreate extends NavigationEvent{
  final bool isCourse;
  CourseCreate({required this.isCourse});
}