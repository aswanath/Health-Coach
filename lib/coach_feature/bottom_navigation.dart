import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/bloc_navigation/navigation_bloc.dart';
import 'package:health_coach/coach_feature/create/view/coach_create_screen.dart';
import 'package:health_coach/coach_feature/home/view/coach_home_screen.dart';
import 'package:health_coach/coach_feature/me/view/coach_me_screen.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/icons.dart';
import 'package:hidable/hidable.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class BottomNavigationCoachScreen extends StatelessWidget {
  const BottomNavigationCoachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          if (state is BlogOrCoachPopup) {
            showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<NavigationBloc>(),
                    child: _SelectionDialog(),
                  );
                });
          }
        },
        child: _Scaffold(
          homeScrollController: ScrollController(),
          createScrollController: ScrollController(),
        ),
      ),
    );
  }
}

class _SelectionDialog extends StatelessWidget {
  const _SelectionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child: SizedBox(
        height: 18.h,
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Select any",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 17.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SelectItems(
                  text: "Course",
                  icon: CustomIcons.courseIcon,
                  onTap: () {
                    context
                        .read<NavigationBloc>()
                        .add(CourseCreate(isCourse: true));
                  },
                ),
                _SelectItems(
                    text: "Blog",
                    icon: CustomIcons.blogIcon,
                    onTap: () {
                      context
                          .read<NavigationBloc>()
                          .add(CourseCreate(isCourse: false));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SelectItems extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String icon;

  const _SelectItems(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
            border: Border.all(color: commonGreen),
            borderRadius: BorderRadius.circular(11)),
        child: Column(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Iconify(icon),
          ],
        ),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  final ScrollController homeScrollController;
  final ScrollController createScrollController;
  List<Widget> screens = [];

  _Scaffold({
    required this.homeScrollController,
    required this.createScrollController,
    Key? key,
  }) : super(key: key) {
    screens = [
      CoachHomeScreen(
        scrollController: homeScrollController,
      ),
      CoachCreateScreen(),
      CoachMeScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<NavigationBloc, NavigationState>(
              buildWhen: (previous, current) {
            if (current is NavigationBarChanged) {
              return true;
            } else {
              return false;
            }
          }, builder: (context, state) {
            state as NavigationBarChanged;
            int index = state.currentIndex;

            return screens[index];
          }),
          BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              ScrollController _scrollController = homeScrollController;
              if (state is NavigationBarChanged) {
                if (state.currentIndex == 0) {
                  _scrollController = homeScrollController;
                } else if (state.currentIndex == 1) {
                  _scrollController = createScrollController;
                  Navigator.pop(context);
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

  double _createScale = 1;
  String _create = CustomIcons.createPrimaryIcon;
  Color _createColor = commonBlack;

  double _meScale = .95;
  String _me = CustomIcons.mePrimaryIcon;
  Color _meColor = commonBlack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          buildWhen: (previous, current) {
            if (current is NavigationBarChanged) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state is NavigationBarChanged) {
              int index = state.currentIndex;
              if (index == 0) {
                _homeScale = 1.2;
                _home = CustomIcons.homeSecondaryIcon;
                _homeColor = commonGreen;
                _createScale = 1;
                _meScale = .95;
                _create = CustomIcons.createPrimaryIcon;
                _me = CustomIcons.mePrimaryIcon;
                _meColor = commonBlack;
                _createColor = commonBlack;
              } else if (index == 1) {
                _createScale = 1.2;
                _createColor = commonGreen;
                _create = CustomIcons.createSecondaryIcon;
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
                _createScale = 1;
                _homeScale = 1;
                _create = CustomIcons.createPrimaryIcon;
                _home = CustomIcons.homePrimaryIcon;
                _createColor = commonBlack;
                _homeColor = commonBlack;
              }
            }
            return BottomNavigationBar(
              backgroundColor: Colors.grey.shade200,
              onTap: (index) {
                context
                    .read<NavigationBloc>()
                    .add(ChangeIndexEvent(index: index, isCoach: true));
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
                      scale: _createScale,
                      child: Iconify(
                        _create,
                        color: _createColor,
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
