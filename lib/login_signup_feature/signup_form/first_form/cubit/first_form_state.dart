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