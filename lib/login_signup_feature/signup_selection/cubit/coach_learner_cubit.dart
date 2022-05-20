import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/login_signup_feature/signup_form/coach_form/view/coach_form_screen.dart';
import 'package:health_coach/login_signup_feature/signup_form/first_form/view/first_form_screen.dart';
import 'package:health_coach/login_signup_feature/signup_form/learner_form/view/learner_form_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants/constants.dart';

part 'coach_learner_state.dart';

class CoachLearnerCubit extends Cubit<CoachLearnerState> {
  CoachLearnerCubit()
      : super(CoachLearnerInitial(
            textColor: commonBlack, containerColor: commonWhite));

  void coachSelect() {
    emit(CoachSelectedState());
    sharedPreferences.setString('Selected', 'Coach');
  }

  void learnerSelect() {
    emit(LearnerSelectedState());
    sharedPreferences.setString('Selected', 'Learner');
  }

  void popBack(BuildContext context) {
    Navigator.pop(context);
  }

  void navigateToNextScreen(BuildContext context) {
    if(state is CoachSelectedState || state is LearnerSelectedState){
      Navigator.push(
          context,
          PageTransition(
            ///TODO: change to original  one.
              child: SignupFirstFormScreen(), type: PageTransitionType.fade));
    }else{
      emit(NotSelectedState());
    }
  }
}
