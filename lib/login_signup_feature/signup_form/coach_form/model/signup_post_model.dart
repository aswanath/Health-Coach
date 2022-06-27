import 'dart:convert';


String coachRegisterPostToJson(CoachRegisterPost data) => json.encode(data.toJson());

class CoachRegisterPost {
  CoachRegisterPost({
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.certifications,
    required this.streams,
    required this.about,
  });

  String name;
  String username;
  String email;
  int phone;
  String password;
  List<String> certifications;
  List<String> streams;
  String about;

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "email": email,
    "phone": phone,
    "password": password,
    "certifications": List<dynamic>.from(certifications.map((x) => x)),
    "streams": List<dynamic>.from(streams.map((x) => x)),
    "about": about,
  };
}
