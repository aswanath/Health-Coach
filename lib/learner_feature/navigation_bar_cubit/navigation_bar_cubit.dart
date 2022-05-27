import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarChanged(currentIndex: 0));

  void changeIndex(int index)=>emit(NavigationBarChanged(currentIndex: index));
}
