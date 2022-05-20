import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/login_signup_feature/cubit/login_signup_cubit.dart';
import 'package:health_coach/login_signup_feature/login/view/login_screen.dart';
import 'package:health_coach/login_signup_feature/signup_selection/view/coach_learner_selection_screen.dart';
import 'package:health_coach/splash/view/splash.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';


class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginSignupCubit(),
      child: BlocListener<LoginSignupCubit, LoginSignupState>(
        listener: (context, state) {
          if (state is NavigateToLoginScreen) {
            Navigator.push(
                context,
                PageTransition(
                    child: BlocProvider.value(
                      value: context.read<LoginSignupCubit>(),
                      child: LoginScreen(),
                    ),
                    type: PageTransitionType.fade));
            return;
          }
          if (state is NavigateToSignupScreen) {
            Navigator.push(
                context,
                PageTransition(
                    child: CoachLearnerSelection(),
                    type: PageTransitionType.fade));
            return;
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [_BackgroundImage(), _Blur(), _Texts()],
            ),
          ),
        ),
      ),
    );
  }
}

class _Texts extends StatelessWidget {
  _Texts({
    Key? key,
  }) : super(key: key);

  final List<Widget> items = [
    const _QuoteWidget(
        author: 'Mahatma Gandhi',
        content:
            'It is health that is real wealth and not pieces of gold and silver.'),
    const _QuoteWidget(
        author: 'Buddha',
        content:
            'Health is the greatest gift, contentment the greatest wealth, faithfulness the best relationship.'),
    const _QuoteWidget(
        author: 'Dalai Lama',
        content:
            '''Values are related to our emotions, just as we practice physical hygiene to preserve our physical health, we need to observe emotional hygiene to preserve a healthy mind and attitudes.'''),
    const _QuoteWidget(
        author: 'Jim Rohn',
        content:
            'Take care of your body. It’s the only place you have to live in.'),
    const _QuoteWidget(
        author: 'Sasha Cohen',
        content:
            'Follow your dreams, work hard, practice, and persevere. Make sure you eat a variety of foods, get plenty of exercise, and maintain a healthy lifestyle.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        const Logo(),
        CarouselSlider(
          items: items,
          options: CarouselOptions(height: 50.h, autoPlay: true),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                voidCallback: () {
                  context.read<LoginSignupCubit>().navigateLogin();
                },
                text: 'Log In',
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 7.w),
              ),
              CustomElevatedButton(
                foregroundColor: commonGreen,
                backgroundColor: Colors.transparent,
                borderColor: commonGreen,
                voidCallback: () {
                  context.read<LoginSignupCubit>().navigateSignup();
                },
                text: 'Sign Up',
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _QuoteWidget extends StatelessWidget {
  final String content;
  final String author;

  const _QuoteWidget({Key? key, required this.author, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 50.h,
      child: Stack(
        children: [
          Positioned(
            child: Image.asset('assets/images/Quote.png'),
            left: 10.w,
            top: 5.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 45.h,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.w, top: 8.h, bottom: 3.h, right: 10.w),
                  child: AutoSizeText(
                    content,
                    style: themeData.textTheme.displaySmall,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Text(
                  '- $author',
                  style: themeData.textTheme.headlineSmall,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _Blur extends StatelessWidget {
  const _Blur({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
      child: Container(
        color: Colors.white.withOpacity(.65),
      ),
    ));
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
  }) : super(key: key);
  final ImageProvider backgroundImage =
      const AssetImage('assets/images/background.jpg');

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
      ),
    );
  }
}
