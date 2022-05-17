import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()){
    Future.delayed(const Duration(milliseconds: 2400)).then((_) => emit(SplashEnd()));
  }
}
