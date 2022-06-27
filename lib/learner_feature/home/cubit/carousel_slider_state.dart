part of 'carousel_slider_cubit.dart';

@immutable
abstract class CarouselSliderChangedState {}

class CarouselChanged extends CarouselSliderChangedState{
  final int index;
  CarouselChanged({required this.index});
}

class GreetingChanged extends CarouselSliderChangedState{
  final String greeting;
  final String name;
  GreetingChanged({required this.greeting,required this.name});
}