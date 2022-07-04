import 'dart:convert';

List<LockedCourses> lockedCoursesFromJson(List<dynamic> list) => List<LockedCourses>.from(list.map((x) => LockedCourses.fromJson(x)));

String lockedCoursesToJson(List<LockedCourses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LockedCourses {
  LockedCourses({
    required this.id,
    required this.workout,
    required this.program,
    required this.price,
    required this.description,
    required this.diet1,
    required this.video,
    required this.preview,
    required this.dietimage,
    required this.trainer,
    required this.trainerid,
    required this.diet2,
    required this.isBlocked
  });

  String id;
  String workout;
  String program;
  String price;
  String description;
  String diet1;
  String diet2;
  String video;
  String preview;
  String dietimage;
  String trainer;
  String trainerid;
  bool isBlocked;


  factory LockedCourses.fromJson(Map<String, dynamic> json) => LockedCourses(
    id: json["_id"],
    workout: json["workout"],
    program: json["program"],
    price: json["price"],
    description: json["description"],
    diet1: json["diet1"],
    video: json["video"],
    preview: json["preview"],
    dietimage: json["dietimage"],
    trainer: json["trainer"],
    trainerid: json["trainerid"],
    diet2: json["diet2"],
    isBlocked: json["isBlocked"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "workout": workout,
    "program": program,
    "price": price,
    "description": description,
    "diet1": diet1,
    "video": video,
    "preview": preview,
    "dietimage": dietimage,
    "trainer": trainer,
    "trainerid" : trainerid,
    "diet2" : diet2,
    "isBlocked" : isBlocked
  };
}
