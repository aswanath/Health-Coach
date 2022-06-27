class LoginResponse {
  LoginResponse({
    required this.id,
    required this.token,
    required this.name,
     this.profilephoto
  });

  String id;
  String token;
  String name;
  String? profilephoto;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
          id: json["_id"]??json["id"],
          token: json["token"],
          name: json["name"],
          profilephoto: json["profilephoto"]
      );



}
