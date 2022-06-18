part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationBarChanged extends NavigationState {
  final int currentIndex;
  NavigationBarChanged({required this.currentIndex});
}

class BlogOrCoachPopup extends NavigationState{}

class NavigateToCreate extends NavigationState{}
