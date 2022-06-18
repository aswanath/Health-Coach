
import 'package:bloc/bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationBarChanged(currentIndex: 0)){

    on<ChangeIndexEvent>((event, emit) {
      if(event.isCoach==true){
        if(event.index ==1){
          emit(BlogOrCoachPopup());
        }else{
          emit(NavigationBarChanged(currentIndex: event.index));
        }
      }else{
        emit(NavigationBarChanged(currentIndex: event.index));
      }
    });

    on<CourseCreate>((event, emit){
      sharedPreferences.setBool('isCourse', event.isCourse);
      emit(NavigationBarChanged(currentIndex: 1));
    });

  }
}
