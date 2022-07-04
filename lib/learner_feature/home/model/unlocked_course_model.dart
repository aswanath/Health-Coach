import 'dart:convert';

List<UnlockedCourses> unlockedCourseFromJson(List<dynamic> list) =>
    List<UnlockedCourses>.from(list.map((e) => UnlockedCourses.fromJson(e)));

String unlockedCourseToJson(List<UnlockedCourses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnlockedCourses {
  UnlockedCourses({
    required this.id,
    required this.workout,
  });

  String id;
  Workout workout;

  factory UnlockedCourses.fromJson(Map<String, dynamic> json) =>
      UnlockedCourses(
        id: json["_id"],
        workout: Workout.fromJson(json["workout"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "workout": workout.toJson(),
      };
}

class Workout {
  Workout({
    required this.id,
    required this.workout,
    required this.program,
    required this.price,
    required this.description,
    required this.diet1,
    required this.diet2,
    required this.video,
    required this.preview,
    required this.trainer,
    required this.trainerid,
    required this.image,
     this.isBlocked = false
  });

  String id;
  String workout;
  String program;
  int price;
  String description;
  String diet1;
  String video;
  String preview;
  String image;
  String trainer;
  String trainerid;
  String diet2;
  bool isBlocked;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      Workout(
          id: json["_id"],
          workout: json["workout"],
          program: json["program"],
          price: json["price"],
          description: json["description"],
          diet1: json["diet1"],
          diet2: json["diet2"],
          video: json["video"],
          preview: json["preview"],
          trainer: json["trainer"],
          trainerid: json["trainerid"],
          isBlocked: json["isBlocked"]??false,
          image: json["dietimage"]);

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "workout": workout,
        "program": program,
        "price": price,
        "description": description,
        "diet1": diet1,
        "diet2": diet2,
        "video": video,
        "preview": preview,
        "dietimage": image,
        "trainer": trainer,
        "trainerid": trainerid,
        "isBlocked": isBlocked,
      };
}
