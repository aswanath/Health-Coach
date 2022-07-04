import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<FormData> imageToFile(
      {required String imageName, required String fileName}) async {
    var bytes = await rootBundle.load(imageName);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return formDataGenerator(filePath: file.path, fileName: fileName);
  }

  static Future<FormData> formDataGenerator(
      {required String filePath, required String fileName}) async {
    FormData formData = FormData.fromMap(
        {"photo": await MultipartFile.fromFile(filePath, filename: fileName)});
    return formData;
  }
}