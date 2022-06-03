import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/learner_feature/explore/view/learner_explore_screen.dart';
import 'package:health_coach/learner_feature/home/view/learner_home_screen.dart';
import 'package:health_coach/learner_feature/me/view/learner_me_screen.dart';
import 'package:hidable/hidable.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

import 'navigation_bar_cubit/navigation_bar_cubit.dart';

class BottomNavigationLearnerScreen extends StatelessWidget {
  const BottomNavigationLearnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBarCubit(),
      child: _Scaffold(
        homeScrollController: ScrollController(),
        exploreScrollController: ScrollController(),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  final ScrollController homeScrollController;
  final ScrollController exploreScrollController;
  List<Widget> screens = [];

  _Scaffold({
    required this.homeScrollController,
    required this.exploreScrollController,
    Key? key,
  }) : super(key: key) {
    screens = [
      LearnerHomeScreen(
        scrollController: homeScrollController,
      ),
      LearnerExploreScreen(
        scrollController: exploreScrollController,
      ),
      LearnerMeScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<NavigationBarCubit, NavigationBarState>(
                  builder: (context, state) {
                    int index = 0;
                    if (state is NavigationBarChanged) {
                      index = state.currentIndex;
                    }
                    return screens[index];
                  }),
              BlocBuilder<NavigationBarCubit, NavigationBarState>(
                builder: (context, state) {
                  ScrollController _scrollController = homeScrollController;
                  if (state is NavigationBarChanged) {
                    if (state.currentIndex == 0) {
                      _scrollController = homeScrollController;
                    } else if (state.currentIndex == 1) {
                      _scrollController = exploreScrollController;
                    }
                  }
                  return Hidable(
                    child: _CustomBottomBar(),
                    controller: _scrollController,
                    size: 11.3.h,
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class _CustomBottomBar extends StatelessWidget {
  _CustomBottomBar({
    Key? key,
  }) : super(key: key);
  static const Duration _scaleDuration = Duration(milliseconds: 300);

  double _homeScale = 1.2;
  String _home = CustomIcons.homeSecondaryIcon;
  Color _homeColor = commonGreen;

  double _exploreScale = 1;
  String _explore = CustomIcons.explorePrimaryIcon;
  Color _exploreColor = commonBlack;

  double _meScale = .95;
  String _me = CustomIcons.mePrimaryIcon;
  Color _meColor = commonBlack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BlocBuilder<NavigationBarCubit, NavigationBarState>(
          builder: (context, state) {
            if (state is NavigationBarChanged) {
              int index = state.currentIndex;
              if (index == 0) {
                _homeScale = 1.2;
                _home = CustomIcons.homeSecondaryIcon;
                _homeColor = commonGreen;
                _exploreScale = 1;
                _meScale = .95;
                _explore = CustomIcons.explorePrimaryIcon;
                _me = CustomIcons.mePrimaryIcon;
                _meColor = commonBlack;
                _exploreColor = commonBlack;
              } else if (index == 1) {
                _exploreScale = 1.2;
                _exploreColor = commonGreen;
                _explore = CustomIcons.exploreSecondaryIcon;
                _homeScale = 1;
                _meScale = .95;
                _home = CustomIcons.homePrimaryIcon;
                _me = CustomIcons.mePrimaryIcon;
                _meColor = commonBlack;
                _homeColor = commonBlack;
              } else if (index == 2) {
                _meScale = 1.15;
                _meColor = commonGreen;
                _me = CustomIcons.meSecondaryIcon;
                _exploreScale = 1;
                _homeScale = 1;
                _explore = CustomIcons.explorePrimaryIcon;
                _home = CustomIcons.homePrimaryIcon;
                _exploreColor = commonBlack;
                _homeColor = commonBlack;
              }
            }
            return BottomNavigationBar(
              backgroundColor: Colors.grey.shade200,
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
                    icon: AnimatedScale(
                      duration: _scaleDuration,
                      scale: _exploreScale,
                      child: Iconify(
                        _explore,
                        color: _exploreColor,
                        size: 23.sp,
                      ),
                    )),
                BottomNavigationBarItem(
                    label: '',
                    icon: AnimatedScale(
                      scale: _meScale,
                      duration: _scaleDuration,
                      child: Iconify(
                        _me,
                        color: _meColor,
                        size: 23.sp,
                      ),
                    )),
              ],
              showUnselectedLabels: false,
            );
          },
        ),
      ),
    );
  }
}