import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:health_coach/constants/api_constants.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:meta/meta.dart';

part 'carousel_slider_state.dart';

class CarouselSliderCubit extends Cubit<CarouselSliderChangedState> {
  CarouselSliderCubit() : super(CarouselChanged(index: 0));

  void changeIndex(int index){
    emit(CarouselChanged(index: index));
  }
  void greetingChange(){
    final userName = json.decode(sharedPreferences.getString(tokenKey)!)["name"];
    final time = DateTime.now() ;
    if(time.hour>=0&&time.hour<12){
      emit(GreetingChanged(greeting: 'Morning',name: userName));
    }else if(time.hour>=12&&time.hour<=18){
      emit(GreetingChanged(greeting: 'Afternoon',name: userName));
    }else{
      emit(GreetingChanged(greeting: 'Evening',name: userName));
    }
  }
}
