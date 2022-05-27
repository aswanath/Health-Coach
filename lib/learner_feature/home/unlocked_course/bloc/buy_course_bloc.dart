import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buy_course_event.dart';
part 'buy_course_state.dart';

class BuyCourseBloc extends Bloc<BuyCourseEvent, BuyCourseState> {
  BuyCourseBloc() : super(BuyCourseInitial()) {
    on<BuyCourseEvent>((event, emit) {
      if(event is BuyNowClicked){
        emit(BuyCourseSuccess());
      }
    });
  }
}
