import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('isFirst', true);
  await apiCacheManager.emptyCache();
  // print(sharedPreferences.getString(tokenKey));
  // sharedPreferences.clear();
  runApp(const MyApp());
}

