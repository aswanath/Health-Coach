import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/learner_feature/explore/explore_screen.dart';
import 'package:health_coach/learner_feature/home/home_screen.dart';
import 'package:health_coach/learner_feature/me/me_screen.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

import 'navigation_bar_cubit/navigation_bar_cubit.dart';

class BottomNavigationLearnerScreen extends StatelessWidget {
  const BottomNavigationLearnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBarCubit(),
      child: _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
  }) : super(key: key);

   static const List<Widget> screens = [
    HomeScreen(),
    ExploreScreen(),
    MeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      bottomNavigationBar: _CustomBottomBar(),
      body: BlocBuilder<NavigationBarCubit, NavigationBarState>(
          builder: (context, state) {
        int index = 0;
        if (state is NavigationBarChanged) {
          index = state.currentIndex;
        }
        return screens[index];
      }),
    ));
  }
}

class _CustomBottomBar extends StatelessWidget {
  _CustomBottomBar({
    Key? key,
  }) : super(key: key);
  static const Duration _animationDuration = Duration(milliseconds: 800);
  static const Duration _scaleDuration = Duration(milliseconds: 600);

  double _homeScale = 1.2;
  String _home = homeSecondaryIcon;
  Color _homeColor = commonGreen;

  AnimationController? _exploreAnimation;
  double _exploreScale = 1;
  String _explore = explorePrimaryIcon;
  Color _exploreColor = commonBlack;

  AnimationController? _meAnimation;
  double _meScale = .95;
  String _me = mePrimaryIcon;
  Color _meColor = commonBlack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: commonGreen.withOpacity(.09))
            ],
            borderRadius: BorderRadius.circular(11)
          ),
          child: BlocBuilder<NavigationBarCubit, NavigationBarState>(
            builder: (context, state) {
              if (state is NavigationBarChanged) {
                int index = state.currentIndex;
                if (index == 0) {
                  _homeScale = 1.2;
                  _home = homeSecondaryIcon;
                  _homeColor = commonGreen;
                  _exploreScale = 1;
                  _meScale = .95;
                  _explore = explorePrimaryIcon;
                  _me = mePrimaryIcon;
                  _meColor = commonBlack;
                  _exploreColor = commonBlack;
                } else if (index == 1) {
                  _exploreAnimation!.reset();
                  _exploreAnimation!.forward();
                  _exploreScale = 1.2;
                  _exploreColor = commonGreen;
                  _explore = exploreSecondaryIcon;
                  _homeScale = 1;
                  _meScale = .95;
                  _home = homePrimaryIcon;
                  _me = mePrimaryIcon;
                  _meColor = commonBlack;
                  _homeColor = commonBlack;
                } else if (index == 2) {
                  _meAnimation!.reset();
                  _meAnimation!.forward();
                  _meScale = 1.15;
                  _meColor = commonGreen;
                  _me = meSecondaryIcon;
                  _exploreScale = 1;
                  _homeScale = 1;
                  _explore = explorePrimaryIcon;
                  _home = homePrimaryIcon;
                  _exploreColor=commonBlack;
                  _homeColor = commonBlack;
                }
              }
              return BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                onTap: (index) {
                  context.read<NavigationBarCubit>().changeIndex(index);
                },
                showSelectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                      label: '',
                      icon: AnimatedScale(
                        duration: _scaleDuration,
                        scale: _homeScale,
                        child: Iconify(
                          _home,
                          color: _homeColor,
                          size: 23.sp,
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Spin(
                        duration: _animationDuration,
                        animate: false,
                        controller: (controller) {
                          _exploreAnimation = controller;
                        },
                        manualTrigger: true,
                        child: AnimatedScale(
                          duration: _scaleDuration,
                          scale: _exploreScale,
                          child: Iconify(
                            _explore,
                            color: _exploreColor,
                            size: 23.sp,
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Swing(
                        animate: false,
                        manualTrigger: true,
                        controller: (controller) {
                          _meAnimation = controller;
                        },
                        duration: _animationDuration,
                        child: AnimatedScale(
                          scale: _meScale,
                          duration: _scaleDuration,
                          child: Iconify(
                            _me,
                            color: _meColor,
                            size: 23.sp,
                          ),
                        ),
                      )),
                ],
                showUnselectedLabels: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
