import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_coach/splash/view/splash.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:sizer/sizer.dart';


import 'constants/constants.dart';
import 'login_signup_feature/selection/view/login_signup_selection_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: commonGreen,
      // systemNavigationBarColor: commonBlack,
    ));
    cachingImage(context);
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeData,
            home: const SelectionScreen(),
          );
        }
    );
  }
}

void cachingImage(BuildContext context){
  precacheImage(const AssetImage('assets/images/background.jpg'), context);
}