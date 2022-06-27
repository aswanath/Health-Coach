// import 'dart:convert';
//
// List<LockedCourses> lockedCoursesFromJson(String str) => List<LockedCourses>.from(json.decode(str).map((x) => LockedCourses.fromJson(x)));
//
// String lockedCoursesToJson(List<LockedCourses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class LockedCourses {
//   LockedCourses({
//     this.id,
//     this.workout,
//     this.program,
//     this.price,
//     this.description,
//     this.diet1,
//     this.diet2,
//     this.video,
//     this.preview,
//     this.dietimage,
//     this.isDeleted,
//     this.trainer,
//     this.trainerid,
//     this.v,
//     this.isBlocked,
//   });
//
//   String id;
//   String workout;
//   String program;
//   String price;
//   String description;
//   String diet1;
//   String diet2;
//   String video;
//   String preview;
//   String dietimage;
//   bool isDeleted;
//   String trainer;
//   String trainerid;
//   int v;
//   bool isBlocked;
//
//   factory LockedCourses.fromJson(Map<String, dynamic> json) => LockedCourses(
//     id: json["_id"],
//     workout: json["workout"],
//     program: json["program"],
//     price: json["price"],
//     description: json["description"],
//     diet1: json["diet1"],
//     diet2: json["diet2"],
//     video: json["video"],
//     preview: json["preview"],
//     dietimage: json["dietimage"],
//     isDeleted: json["isDeleted"],
//     trainer: json["trainer"],
//     trainerid: json["trainerid"],
//     v: json["__v"],
//     isBlocked: json["isBlocked"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "workout": workout,
//     "program": program,
//     "price": price,
//     "description": description,
//     "diet1": diet1,
//     "diet2": diet2,
//     "video": video,
//     "preview": preview,
//     "dietimage": dietimage,
//     "isDeleted": isDeleted,
//     "trainer": trainer,
//     "trainerid": trainerid,
//     "__v": v,
//     "isBlocked": isBlocked,
//   };
// }
