import 'dart:convert';

import 'package:health_coach/learner_feature/home/model/locked_courses_model.dart';


BuyCourseModel buyCourseModelFromJson(String str) => BuyCourseModel.fromJson(json.decode(str));

String buyCourseModelToJson(BuyCourseModel data) => json.encode(data.toJson());

class BuyCourseModel {
  BuyCourseModel({
    required this.paymentdetails,
    required this.item,
  });

  Paymentdetails paymentdetails;
  LockedCourses item;

  factory BuyCourseModel.fromJson(Map<String, dynamic> json) => BuyCourseModel(
    paymentdetails: Paymentdetails.fromJson(json["paymentdetails"]),
    item: LockedCourses.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "paymentdetails": paymentdetails.toJson(),
    "item": item.toJson(),
  };
}

class Paymentdetails {
  Paymentdetails({
    required this.paymentMethodData,
  });

  PaymentMethodData paymentMethodData;

  factory Paymentdetails.fromJson(Map<String, dynamic> json) => Paymentdetails(
    paymentMethodData: PaymentMethodData.fromJson(json["paymentMethodData"]),
  );

  Map<String, dynamic> toJson() => {
    "paymentMethodData": paymentMethodData.toJson(),
  };
}

class PaymentMethodData {
  PaymentMethodData({
    required this.description,
    required this.type,
    required this.info,
  });

  String description;
  String type;
  String info;

  factory PaymentMethodData.fromJson(Map<String, dynamic> json) => PaymentMethodData(
    description: json["description"],
    type: json["type"],
    info: json["info"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "type": type,
    "info": info,
  };
}
