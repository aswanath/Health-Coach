import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/bloc_navigation/navigation_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/learner_feature/explore/view/learner_explore_screen.dart';
import 'package:health_coach/learner_feature/home/view/learner_home_screen.dart';
import 'package:health_coach/learner_feature/me/view/learner_me_screen.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

class BottomNavigationLearnerScreen extends StatelessWidget {
  const BottomNavigationLearnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        ],
        child: _Scaffold());
  }
}

class _Scaffold extends StatelessWidget {
  final PageController pageController = PageController();

  _Scaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return _CustomBottomBar(
            pageController: pageController,
          );
        },
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              LearnerHomeScreen(),
              LearnerExploreScreen(),
              LearnerMeScreen()
            ],
          ),
        ],
      ),
    ));
  }
}

class _CustomBottomBar extends StatelessWidget {
  final PageController pageController;

  _CustomBottomBar({
    required this.pageController,
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
  String _me = CustomIcons.meSecondaryIcon;
  Color _meColor = commonBlack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        border:Border.all(color: commonGreen),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
        child: BlocBuilder<NavigationBloc, NavigationState>(
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
                _me = CustomIcons.meSecondaryIcon;
                _meColor = commonBlack;
                _exploreColor = commonBlack;
              } else if (index == 1) {
                _exploreScale = 1.2;
                _exploreColor = commonGreen;
                _explore = CustomIcons.exploreSecondaryIcon;
                _homeScale = 1;
                _meScale = .95;
                _home = CustomIcons.homePrimaryIcon;
                _me = CustomIcons.meSecondaryIcon;
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
              backgroundColor: commonWhite,
              onTap: (index) {
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.decelerate);
                context
                    .read<NavigationBloc>()
                    .add(ChangeIndexEvent(index: index, isCoach: false));
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
