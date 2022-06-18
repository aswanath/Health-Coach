import 'dart:convert';

String loginPostToJson(LoginPost data) => json.encode(data.toJson());

class LoginPost {
  LoginPost({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
