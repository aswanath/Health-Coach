import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('isFirst', true);
  await apiCacheManager.emptyCache();
  // final keys = "rzp_test_iVLcMSrumlwXqI:Ak0tXXw52xMKTSyZgl4lapnh";
  // final decoded = base64.encode(utf8.encode(keys));
  // sharedPreferences.clear();
  runApp(const MyApp());
}

