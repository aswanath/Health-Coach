import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const Color commonGreen = Color(0xff0C861F);
const Color commonBlack = Colors.black;
const Color commonWhite = Colors.white;
late SharedPreferences sharedPreferences;
final DefaultCacheManager defaultCacheManager = DefaultCacheManager();
final APICacheManager apiCacheManager = APICacheManager();
const List<String> avatarList = [
  'assets/images/avatars/one.png',
  'assets/images/avatars/two.png',
  'assets/images/avatars/three.png',
  'assets/images/avatars/four.png',
  'assets/images/avatars/five.png',
  'assets/images/avatars/six.png',
  'assets/images/avatars/seven.png',
  'assets/images/avatars/eight.png',
];
final RegExp noSpaceRegExp = RegExp(r'/^\S*$/');
const String tokenKey = 'token';







