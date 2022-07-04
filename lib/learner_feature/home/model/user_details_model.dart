// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
    required this.name,
    required this.username,
    required this.age,
    required this.email,
    required this.phone,
    required this.weight,
    required this.height,
    required this.healthcondition,
    required this.password,
    required this.profilephoto,
  });

  String name;
  String username;
  int age;
  String email;
  int phone;
  int weight;
  int height;
  String healthcondition;
  String password;
  String profilephoto;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    name: json["name"],
    username: json["username"],
    age: json["age"],
    email: json["email"],
    phone: json["phone"],
    weight: json["weight"],
    height: json["height"],
    healthcondition: json["healthcondition"],
    password: json["password"],
    profilephoto: json["profilephoto"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "age": age,
    "email": email,
    "phone": phone,
    "weight": weight,
    "height": height,
    "healthcondition": healthcondition,
    "password": password,
    "profilephoto": profilephoto,
  };
}
