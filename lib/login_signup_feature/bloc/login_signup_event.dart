part of 'login_signup_bloc.dart';

@immutable
abstract class LoginSignupEvent {}

class SelectLoginType extends LoginSignupEvent {
  final UserType userType;

  SelectLoginType({required this.userType});
}

class NavigateToLogin extends LoginSignupEvent {}

class NavigateToSignup extends LoginSignupEvent {}

class CoachAdminLearnerSelect extends LoginSignupEvent {}

class LoginUserCheck extends LoginSignupEvent {
  final String username;
  final String password;
  final UserType userType;

  LoginUserCheck(
      {required this.password, required this.username, required this.userType});
}

class FirstFormEvent extends LoginSignupEvent {
  final String? name;
  final String? userName;
  final String? email;
  final int? phone;
  final String? password;
  final String? imagePath;
  final bool? isGallery;

  FirstFormEvent(
      {
       this.name,
       this.userName,
       this.email,
       this.phone,
        this.imagePath,
        this.isGallery,
       this.password});

FirstFormEvent copyWith({String? name, String? userName, String? email, int? phone, String? password,String? imagePath,bool? isGallery}) {
    return FirstFormEvent(
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      imagePath: imagePath ?? this.imagePath,
      isGallery: isGallery?? this.isGallery
    );
  }
}


class LearnerFormEvent extends LoginSignupEvent {
  final int? age;
  final int? height;
  final int? weight;
  final String? healthCondition;

  LearnerFormEvent(
      { this.age,
       this.height,
       this.weight,
       this.healthCondition});

  LearnerFormEvent copyWith({int? age, int? height, int? weight, String? healthCondition}) {
    return LearnerFormEvent(
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      healthCondition: healthCondition ?? this.healthCondition,
    );
  }
}


class CoachFormEvent extends LoginSignupEvent{
  final List<String>? certifications;
  final List<String>? streams;
  final String? about;
  CoachFormEvent({
    this.about,
    this.certifications,
    this.streams,
});

  CoachFormEvent copyWith({List<String>? certifications, List<String>? streams, String? about}) {
    return CoachFormEvent(
      certifications: certifications ?? this.certifications,
      streams: streams ?? this.streams,
      about: about ?? this.about,
    );
  }
}

class LearnerRegisterCheck extends LoginSignupEvent{}

class CoachRegisterCheck extends LoginSignupEvent{}