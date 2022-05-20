part of 'first_form_cubit.dart';

@immutable
abstract class FirstFormState {}

class ImageInitialState extends FirstFormState {
  final String imagePath;
  ImageInitialState({required this.imagePath});
}

class ImageUpdateState extends FirstFormState{
  final bool isGallery;
  final String imagePath;
  ImageUpdateState({required this.imagePath,required this.isGallery});
}

class ShowAvatarGalleryPopup extends FirstFormState{}

class ShowSelectAvatarPopup extends FirstFormState{}

class EnableNextButton extends FirstFormState{}

class DisableNextButton extends FirstFormState{}

class EnableNextButtonLearner extends FirstFormState{}

class DisableNextButtonLearner extends FirstFormState{}

class EnableNextButtonCoach extends FirstFormState{}

class DisableNextButtonCoach extends FirstFormState{}

class PopBack extends FirstFormState{}

class PopBackLearner extends FirstFormState{}

class PopBackCoach extends FirstFormState{}

class RegisterSuccessPopup extends FirstFormState{}

class RegisterSuccessPopUpCoach extends FirstFormState{}