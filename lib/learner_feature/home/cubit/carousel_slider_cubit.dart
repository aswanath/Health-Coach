import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_slider_state.dart';

class CarouselSliderCubit extends Cubit<CarouselSliderChangedState> {
  CarouselSliderCubit() : super(CarouselChanged(index: 0));

  void changeIndex(int index){
    emit(CarouselChanged(index: index));
  }
  void greetingChange(){
    final time = DateTime.now() ;
    if(time.hour>=0&&time.hour<12){
      emit(GreetingChanged(greeting: 'Morning'));
    }else if(time.hour>=12&&time.hour<=18){
      emit(GreetingChanged(greeting: 'Afternoon'));
    }else{
      emit(GreetingChanged(greeting: 'Evening'));
    }
  }
}
