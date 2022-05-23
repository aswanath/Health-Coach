part of 'navigation_bar_cubit.dart';

@immutable
abstract class NavigationBarState {}

class NavigationBarInitial extends NavigationBarState{}

class NavigationBarChanged extends NavigationBarState {
  final int currentIndex;
  NavigationBarChanged({required this.currentIndex});
}
