import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/login_signup_feature/selection/view/login_signup_selection_screen.dart';
import 'package:health_coach/splash/cubit/splash_cubit.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashEnd) {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: const SelectionScreen(),
                    type: PageTransitionType.fade));
          }
        },
        child: const SafeArea(
          child: Scaffold(
            body: Logo(),
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeftBig(
            from: 100,
            child: Text(
              'Health',
              style: themeData.textTheme.displayMedium,
            ),
          ),
          FadeInRightBig(
            from: 100,
            child: Text(
              'Coach',
              style: themeData.textTheme.displayLarge,
            ),
          ),
        ],
      ),
    );
  }
}
