import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/login_signup_feature/login/view/login_screen.dart';
import 'package:health_coach/login_signup_feature/signup_form/coach_form/view/coach_form_screen.dart';
import 'package:health_coach/login_signup_feature/signup_form/learner_form/view/learner_form_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:health_coach/custom_classes/validator_mixin.dart';

part 'first_form_state.dart';

class FirstFormCubit extends Cubit<FirstFormState> with InputValidatorMixin {
  bool nameCheck = false;
  bool emailCheck = false;
  bool mobileCheck = false;
  bool passwordCheck = false;
  bool ageCheck = false;
  bool heightCheck = true;
  bool weightCheck = true;
  bool qualificationCheck = false;
  bool streamCheck = false;
  bool aboutCheck = false;

  FirstFormCubit() : super(ImageInitialState(imagePath: avatarList[3]));

  void selectAvatarGalleryDialog() => emit(ShowAvatarGalleryPopup());

  void selectAvatar() => emit(ShowSelectAvatarPopup());

  void updateAvatar(int index) =>
      emit(ImageUpdateState(imagePath: avatarList[index], isGallery: false));

  Future selectGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      emit(ImageUpdateState(imagePath: _image.path, isGallery: true));
    }
  }

  void navigateToNext(BuildContext context) {
    final result = sharedPreferences.getString("Selected");
    if (result == "Coach") {
      Navigator.push(
          context,
          PageTransition(
              child: BlocProvider.value(
                value: context.read<FirstFormCubit>(),
                child: CoachFormScreen(),
              ),
              type: PageTransitionType.fade));
    } else if (result == "Learner") {
      emit(DisableNextButtonLearner());
      Navigator.push(
          context,
          PageTransition(
              child: BlocProvider.value(
                value: context.read<FirstFormCubit>(),
                child: LearnerFormScreen(),
              ),
              type: PageTransitionType.fade));
    }
  }

  void gotToLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(child: LoginScreen(), type: PageTransitionType.fade),
        (route) => false);
  }

  void registerSuccessDialog() =>
    emit(RegisterSuccessPopup());

  void registerSuccessDialogCoach()=> emit(RegisterSuccessPopUpCoach());

  void popBack() => emit(PopBack());

  void popBackLearner() => emit(PopBackLearner());

  void popBackCoach() => emit(PopBackCoach());

  void enableNextButton() {
    if (nameCheck == true &&
        emailCheck == true &&
        mobileCheck == true &&
        passwordCheck == true) {
      emit(EnableNextButton());
    } else {
      emit(DisableNextButton());
    }
  }

  void enableNextButtonLearner() {
    if (ageCheck == true && weightCheck == true && heightCheck == true) {
      emit(EnableNextButtonLearner());
    } else {
      emit(DisableNextButtonLearner());
    }
  }

  void enableNextButtonCoach(){
    if(qualificationCheck == true&&streamCheck==true&&aboutCheck==true){
     emit(EnableNextButtonCoach());
    }else{
      emit(DisableNextButtonCoach());
    }
  }

  void checkAge(String? value) {
    final result = isAgeValid(value);
    if (result == null) {
      ageCheck = true;
    } else {
      ageCheck = false;
    }
    enableNextButtonLearner();
  }

  void checkHeight(String? value) {
    final result = isHeightValid(value);
    if (result == null) {
      heightCheck = true;
    } else {
      heightCheck = false;
    }
    enableNextButtonLearner();
  }

  void checkWeight(String? value) {
    final result = isWeightValid(value);
    if (result == null) {
      weightCheck = true;
    } else {
      weightCheck = false;
    }
    enableNextButtonLearner();
  }

  void checkName(String? value) {
    final result = isNameValid(value);
    if (result == null) {
      nameCheck = true;
    } else {
      nameCheck = false;
    }
    enableNextButton();
  }

  void checkEmail(String? value) {
    final result = isEmailValid(value);
    if (result == null) {
      emailCheck = true;
    } else {
      emailCheck = false;
    }
    enableNextButton();
  }

  void checkMobile(String? value) {
    final result = isMobileValid(value);
    if (result == null) {
      mobileCheck = true;
    } else {
      mobileCheck = false;
    }
    enableNextButton();
  }

  void checkPassword(String? value) {
    final result = isPasswordValid(value);
    if (result == null) {
      passwordCheck = true;
    } else {
      passwordCheck = false;
    }
    enableNextButton();
  }

  void checkQualification(String? value){
    final result = isQualificationValid(value);
    if(result == null){
      qualificationCheck = true;
    }else{
      qualificationCheck = false;
    }
    enableNextButtonCoach();
  }

  void checkStream(String? value){
     final result = isStreamValid(value);
     if(result == null){
       streamCheck = true;
     }else{
       streamCheck = false;
     }
     enableNextButtonCoach();
  }

  void checkAbout(String? value){
    final result = isAboutValid(value);
    if(result == null){
      aboutCheck = true;
    }else{
      aboutCheck = false;
    }
    enableNextButtonCoach();
  }
}
