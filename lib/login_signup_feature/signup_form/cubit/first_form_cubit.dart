import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/login_signup_feature/login/view/login_screen.dart';
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
  bool heightCheck = false;
  bool weightCheck = false;
  bool healthCheck = false;
  bool qualificationCheck = false;
  bool streamCheck = false;
  bool aboutCheck = false;
  bool userNameCheck = false;

  late String name;
  late String userName;
  late String email;
  late int phone;
  late String password;
  late int age;
  late int height;
  late int weight;
  late String healthCondition;

  FirstFormCubit() : super(ImageInitialState(imagePath: avatarList[3]));

  void selectAvatarGalleryDialog() => emit(ShowAvatarGalleryPopup());

  void selectAvatar() => emit(ShowSelectAvatarPopup());

  void updateAvatar(int index) {
    emit(ImageUpdateState(imagePath: avatarList[index], isGallery: false));
  }

  Future selectGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      emit(ImageUpdateState(imagePath: _image.path, isGallery: true));
    }
  }

  void navigateToNext() {
    final result = sharedPreferences.getString("Selected");
    if (result == "Coach") {
      emit(NavigateToCoachFormScreen());
    } else if (result == "Learner") {
      emit(NavigateToLearnerFormScreen());
    }
  }

  void gotToLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: const LoginScreen(), type: PageTransitionType.fade),
        (route) => false);
  }

  void registerSuccessDialog() => emit(RegisterSuccessPopup());

  void registerSuccessDialogCoach() => emit(RegisterSuccessPopUpCoach());

  void enableNextButton() {
    if (nameCheck == true &&
        emailCheck == true &&
        mobileCheck == true &&
        passwordCheck == true &&
        userNameCheck == true) {
      emit(EnableNextButton());
    } else {
      emit(DisableNextButton());
    }
  }

  void enableNextButtonLearner() {
    if (ageCheck == true &&
        weightCheck == true &&
        heightCheck == true &&
        healthCheck == true) {
      emit(EnableNextButtonLearner());
    } else {
      emit(DisableNextButtonLearner());
    }
  }

  void enableNextButtonCoach() {
    if (qualificationCheck == true &&
        streamCheck == true &&
        aboutCheck == true) {
      emit(EnableNextButtonCoach());
    } else {
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

  void checkHealth(String? value) {
    final result = isHealthValid(value);
    if (result == null) {
      healthCheck = true;
    } else {
      healthCheck = false;
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

  void checkUserName(String? value) {
    final result = isUserNameValid(value);
    if (result == null) {
      userNameCheck = true;
    } else {
      userNameCheck = false;
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

  void checkQualification(String? value) {
    final result = isQualificationValid(value);
    if (result == null) {
      qualificationCheck = true;
    } else {
      qualificationCheck = false;
    }
    enableNextButtonCoach();
  }

  void checkStream(String? value) {
    final result = isStreamValid(value);
    if (result == null) {
      streamCheck = true;
    } else {
      streamCheck = false;
    }
    enableNextButtonCoach();
  }

  void checkAbout(String? value) {
    final result = isAboutValid(value);
    if (result == null) {
      aboutCheck = true;
    } else {
      aboutCheck = false;
    }
    enableNextButtonCoach();
  }

  // void setName(String? value) {
  //   name = value!;
  // }
  //
  // void setUserName(String? value) {
  //   userName = value!;
  // }
  //
  // void setEmail(String? value) {
  //   email = value!;
  // }
  //
  // void setPhone(String? value) {
  //   phone = int.parse(value!);
  // }
  //
  // void setPassword(String? value) {
  //   password = value!;
  // }
  //
  // void setAge(String? value) {
  //   age = int.parse(value!);
  // }
  //
  // void setHeight(String? value) {
  //   height = int.parse(value!);
  // }
  //
  // void setWeight(String? value) {
  //   weight = int.parse(value!);
  // }
  //
  // void setHealthCondition(String? value) {
  //   healthCondition = value!;
  // }
}
