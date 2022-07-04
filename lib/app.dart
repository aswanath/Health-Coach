import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:health_coach/coach_feature/bottom_navigation.dart';
import 'package:health_coach/coach_feature/create/view/coach_create_screen.dart';
import 'package:health_coach/internet_connection/internet_bloc.dart';
import 'package:health_coach/learner_feature/bottom_navigation.dart';
import 'package:health_coach/repository/repository.dart';
import 'package:health_coach/splash/view/splash.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

import 'constants/constants.dart';
import 'custom_classes/custom_scroll_behaviour.dart';
import 'learner_feature/bloc/learner_bloc.dart';

import 'login_signup_feature/selection/view/login_signup_selection_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cachingImage(context);
    return Sizer(builder: (context, orientation, deviceType) {
      return OverlaySupport.global(
        child: RepositoryProvider(
          create: (context) => Repository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LearnerBloc>(create: (context) => LearnerBloc(repository: context.read<Repository>()),),
              BlocProvider<InternetBloc>(create: (context)=> InternetBloc()),
            ],
            child: BlocBuilder<InternetBloc, InternetState>(
              builder: (context, state) {
                return GetMaterialApp(
                  scrollBehavior: CustomScroll(),
                  debugShowMaterialGrid: false,
                  debugShowCheckedModeBanner: false,
                  title: 'Health Coach',
                  theme: themeData,
                  home: const SplashScreen(),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

void cachingImage(BuildContext context) {
  precacheImage(const AssetImage('assets/images/background.jpg'), context);
}
