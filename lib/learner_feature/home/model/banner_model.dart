
class HomeBanner {
  HomeBanner({
    required this.title1,
    this.title2 = "Hard work pays off",
    this.title3 = "You are never alone",
    required this.image1,
    required this.image2,
    required this.image3,
  });

  String title1;
  String title2;
  String title3;
  String image1;
  String image2;
  String image3;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => HomeBanner(
    title1: json["title"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
  );

}
