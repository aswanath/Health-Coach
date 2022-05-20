import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color commonGreen = Color(0xff0C861F);
const Color commonBlack = Colors.black;
const Color commonWhite = Colors.white;
late SharedPreferences sharedPreferences;

const List<String> avatarList = [
  'assets/images/avatars/one.png',
  'assets/images/avatars/two.png',
  'assets/images/avatars/three.png',
  'assets/images/avatars/four.png',
  'assets/images/avatars/five.png',
  'assets/images/avatars/six.png',
  'assets/images/avatars/seven.png',
  'assets/images/avatars/eight.png',
];

RegExp noSpaceRegExp = RegExp(r'/^\S*$/');

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

mixin InputValidatorMixin {
  String? isNameValid(String? value) {
    if (value!.isEmpty) {
      return "Name can't be empty";
    }
    if (value.isNotEmpty && value.length < 3) {
      return "Please enter a valid name";
    } else {
      return null;
    }
  }

  String? isEmailValid(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Email can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }

  String? isMobileValid(String? value) {
    String pattern = r'^[6789]\d{9}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Mobile can't be empty";
    }
    if (value.length < 10 || value.length > 10 || !regExp.hasMatch(value)) {
      return "Please enter a valid mobile number";
    } else {
      return null;
    }
  }

  String? isPasswordValid(String? value) {
    if (value!.length < 8) {
      return "Password must contain 8 characters";
    } else {
      return null;
    }
  }

  String? isAgeValid(String? value){
    if(value!.isEmpty){
      return "Age can't be empty";
    }else{
      int age = int.parse(value);
      if(age>99||age<5){
       return "Please enter a valid age between 5 - 99";
      }else{
        return null;
      }
    }
  }

  String? isWeightValid(String? value){
    if(value!.isNotEmpty){
      int weight = int.parse(value);
      if(weight>200||weight<5){
        return "Please enter a valid weight between 5 - 200";
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

  String? isHeightValid(String? value){
    if(value!.isNotEmpty){
      int weight = int.parse(value);
      if(weight>300||weight<50){
        return "Please enter a valid height between 50 - 300";
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

  String? isQualificationValid(String? value){
    if(value!.isNotEmpty){
      return null;
    }else{
      return "Please select your qualification";
    }
  }

  String? isStreamValid(String? value){
    if(value!.isEmpty){
      return "Please enter at least one stream";
    }else{
      return null;
    }
  }

  String? isAboutValid(String? value){
    if(value!.isEmpty){
    return "Please describe yourself";
  }else if(value.length<10){
      return "At least 10 characters";
    }else{
      return null;
    }
    }

}

const String nameIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 26 26"><rect x="0" y="0" width="26" height="26" fill="none" stroke="none" /><path fill="currentColor" d="M16.563 15.9c-.159-.052-1.164-.505-.536-2.414h-.009c1.637-1.686 2.888-4.399 2.888-7.07c0-4.107-2.731-6.26-5.905-6.26c-3.176 0-5.892 2.152-5.892 6.26c0 2.682 1.244 5.406 2.891 7.088c.642 1.684-.506 2.309-.746 2.397c-3.324 1.202-7.224 3.393-7.224 5.556v.811c0 2.947 5.714 3.617 11.002 3.617c5.296 0 10.938-.67 10.938-3.617v-.811c0-2.228-3.919-4.402-7.407-5.557z"/></svg>';
const String emailIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 20 20"><rect x="0" y="0" width="20" height="20" fill="none" stroke="none" /><path fill="currentColor" d="M14.608 12.172c0 .84.239 1.175.864 1.175c1.393 0 2.28-1.775 2.28-4.727c0-4.512-3.288-6.672-7.393-6.672c-4.223 0-8.064 2.832-8.064 8.184c0 5.112 3.36 7.896 8.52 7.896c1.752 0 2.928-.192 4.727-.792l.386 1.607c-1.776.577-3.674.744-5.137.744c-6.768 0-10.393-3.72-10.393-9.456c0-5.784 4.201-9.72 9.985-9.72c6.024 0 9.215 3.6 9.215 8.016c0 3.744-1.175 6.6-4.871 6.6c-1.681 0-2.784-.672-2.928-2.161c-.432 1.656-1.584 2.161-3.145 2.161c-2.088 0-3.84-1.609-3.84-4.848c0-3.264 1.537-5.28 4.297-5.28c1.464 0 2.376.576 2.782 1.488l.697-1.272h2.016v7.057h.002zm-2.951-3.168c0-1.319-.985-1.872-1.801-1.872c-.888 0-1.871.719-1.871 2.832c0 1.68.744 2.616 1.871 2.616c.792 0 1.801-.504 1.801-1.896v-1.68z"/></svg>';
const String mobileIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path fill="currentColor" d="m7.772 2.439l1.076-.344c1.009-.322 2.087.199 2.519 1.217l.86 2.028c.374.883.166 1.922-.514 2.568L9.818 9.706c.117 1.076.479 2.135 1.085 3.177a8.677 8.677 0 0 0 2.27 2.595l2.276-.76c.862-.287 1.802.044 2.33.821l1.233 1.81c.615.904.504 2.15-.259 2.916l-.817.821c-.814.817-1.977 1.114-3.052.778c-2.54-.792-4.873-3.143-7.003-7.053c-2.133-3.916-2.886-7.24-2.258-9.968c.264-1.148 1.081-2.063 2.149-2.404Z"/></svg>';
const String passwordIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path fill="currentColor" d="M18 8h2a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1h2V7a6 6 0 1 1 12 0v1zm-2 0V7a4 4 0 1 0-8 0v1h8zm-5 6v2h2v-2h-2zm-4 0v2h2v-2H7zm8 0v2h2v-2h-2z"/></svg>';
const String ageIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 1024 1024"><rect x="0" y="0" width="1024" height="1024" fill="none" stroke="none" /><path fill="currentColor" d="M866.9 169.9L527.1 54.1C523 52.7 517.5 52 512 52s-11 .7-15.1 2.1L157.1 169.9c-8.3 2.8-15.1 12.4-15.1 21.2v482.4c0 8.8 5.7 20.4 12.6 25.9L499.3 968c3.5 2.7 8 4.1 12.6 4.1s9.2-1.4 12.6-4.1l344.7-268.6c6.9-5.4 12.6-17 12.6-25.9V191.1c.2-8.8-6.6-18.3-14.9-21.2zM694.5 340.7L481.9 633.4a16.1 16.1 0 0 1-26 0l-126.4-174c-3.8-5.3 0-12.7 6.5-12.7h55.2c5.1 0 10 2.5 13 6.6l64.7 89l150.9-207.8c3-4.1 7.8-6.6 13-6.6H688c6.5.1 10.3 7.5 6.5 12.8z"/></svg>';
const String heightIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><rect x="0" y="0" width="24" height="24" fill="none" stroke="none" /><path fill="currentColor" d="M7 2c1.78 0 2.67 2.16 1.42 3.42C7.16 6.67 5 5.78 5 4a2 2 0 0 1 2-2M5.5 7h3a2 2 0 0 1 2 2v5.5H9V22H5v-7.5H3.5V9a2 2 0 0 1 2-2M19 8h2l-3-4l-3 4h2v8h-2l3 4l3-4h-2m3-14h-8v2h8m0 16h-8v2h8"/></svg>';
const String weightIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="img" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 48 48"><rect x="0" y="0" width="48" height="48" fill="none" stroke="none" /><path fill="currentColor" fill-rule="evenodd" d="M40.21 38.222A4 4 0 0 1 36.216 42H11.784a4 4 0 0 1-3.994-3.778l-1.555-28A4 4 0 0 1 10.228 6h27.544a4 4 0 0 1 3.994 4.222l-1.556 28Zm-5.966-20.443c.82-.54 1.026-1.611.353-2.308a14.425 14.425 0 0 0-3.945-2.882a15.254 15.254 0 0 0-6.558-1.587a15.293 15.293 0 0 0-6.611 1.382a14.508 14.508 0 0 0-4.045 2.756c-.697.676-.53 1.752.271 2.318l4.312 3.046c.8.566 1.928.383 2.757-.145a5.58 5.58 0 0 1 .667-.362a5.775 5.775 0 0 1 2.344-.523l3.393-3.901a1 1 0 0 1 1.51 1.312L26.06 19.91a5.652 5.652 0 0 1 1.016.548c.81.553 1.93.77 2.75.23l4.417-2.91Z" clip-rule="evenodd"/></svg>';
