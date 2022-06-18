// // To parse this JSON data, do
// //
// //     final login = loginFromJson(jsonString);
//
// import 'dart:convert';
//
// Login loginFromJson(String str) => Login.fromJson(json.decode(str));
//
// String loginToJson(Login data) => json.encode(data.toJson());
//
// class Login {
//   Login({
//     this.id,
//     this.name,
//     this.username,
//     this.email,
//     this.phone,
//     this.weight,
//     this.height,
//     this.age,
//     this.profilephoto,
//     this.healthcondition,
//     this.token,
//   });
//
//   String id;
//   String name;
//   String username;
//   String email;
//   int phone;
//   int weight;
//   int height;
//   int age;
//   dynamic profilephoto;
//   String healthcondition;
//   String token;
//
//   factory Login.fromJson(Map<String, dynamic> json) => Login(
//     id: json["_id"],
//     name: json["name"],
//     username: json["username"],
//     email: json["email"],
//     phone: json["phone"],
//     weight: json["weight"],
//     height: json["height"],
//     age: json["age"],
//     profilephoto: json["profilephoto"],
//     healthcondition: json["healthcondition"],
//     token: json["token"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "username": username,
//     "email": email,
//     "phone": phone,
//     "weight": weight,
//     "height": height,
//     "age": age,
//     "profilephoto": profilephoto,
//     "healthcondition": healthcondition,
//     "token": token,
//   };
// }
