import 'dart:convert';

class PostRequests {
  static const String postLearnerLogin = "https://eshopee.online/api/user/login";
  static const String postAdminLogin = 'https://urbanclassic.online/api/admin';
  static const String postCoachLogin =
      "https://eshopee.online/api/trainers/trainerlogin";
  static const String postLearnerRegister = 'https://eshopee.online/api/user';
  static const String postOrderIdGenerator = "https://api.razorpay.com/v1/orders";
  static const String postBuyCourse = "https://eshopee.online/api/payment";
}

class GetRequests {
  static const String getHomeBanner = "https://eshopee.online/api/banner";
  static const String getUserDetails = "https://eshopee.online/api/user/";
  static const String getUserUnlockedCourses = "https://eshopee.online/api/subcribe/";
  static const String getAllCourses = "https://eshopee.online/api/workout";
}

class PatchRequests {
  static const String patchImageUpload =
      "https://eshopee.online/api/user/profilephoto";
}

class Keys{
  static const String keyId = "rzp_test_22c50Bf7OzyK3W";
  static const String keySecret = "8qH0ap67BvSvZi5BZITQKjvJ";
  static const String combination = "$keyId:$keySecret";
  static String baseAuthorizationToken = base64.encode(utf8.encode(combination));
}
