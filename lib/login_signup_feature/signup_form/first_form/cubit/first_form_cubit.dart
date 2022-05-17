import 'package:bloc/bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'first_form_state.dart';

class FirstFormCubit extends Cubit<FirstFormState> {
  FirstFormCubit() : super(ImageInitialState(imagePath: avatarList[3]));

  void selectAvatarGalleryDialog() => emit(ShowAvatarGalleryPopup());

  void selectAvatar() => emit(ShowSelectAvatarPopup());

  void updateAvatar(int index)=> emit(ImageUpdateState(imagePath: avatarList[index], isGallery: false));

  Future selectGallery() async{
   final ImagePicker _imagePicker = ImagePicker();
   XFile? _image = await _imagePicker.pickImage(source: ImageSource.gallery);
   if(_image!=null){
     print("emitting gallery");
      emit(ImageUpdateState(imagePath: _image.path, isGallery: true));
   }
  }
}
