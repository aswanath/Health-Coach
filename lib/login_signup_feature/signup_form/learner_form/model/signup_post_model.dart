
import 'dart:convert';

String learnerRegisterPostToJson(LearnerRegisterPost data) => json.encode(data.toJson());

class LearnerRegisterPost {
  LearnerRegisterPost({
    required this.name,
    required this.username,
    required this.age,
    required this.email,
    required this.phone,
    required this.weight,
    required this.height,
    required this.healthcondition,
    required this.password,
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
  };
}
