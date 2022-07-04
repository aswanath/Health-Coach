import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/list_tile.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/learner_feature/bloc/learner_bloc.dart';
import 'package:health_coach/learner_feature/me/edit_profile/view/profile_edit.dart';
import 'package:health_coach/learner_feature/me/my_courses/view/me_my_courses.dart';
import 'package:health_coach/login_signup_feature/selection/view/login_signup_selection_screen.dart';
import 'package:health_coach/login_signup_feature/signup_form/first_form/view/first_form_screen.dart';
import 'package:health_coach/repository/repository.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class LearnerMeScreen extends StatelessWidget {
  const LearnerMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LearnerBloc, LearnerState>(
        listener: (context, state) {
          if (state is LogOutState) {
            Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const SelectionScreen(),
                  type: PageTransitionType.topToBottom,
                  duration: const Duration(milliseconds: 300)),
            );
          }
        },
        child: const _Scaffold());
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Align(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const EditProfileScreen(),
                        type: PageTransitionType.fade));
              },
              child: const Hero(
                tag: 'edit',
                child: _ImageEdit(),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Align(child: BlocBuilder<LearnerBloc, LearnerState>(
            builder: (context, state) {
              return Text(
                context.read<Repository>().name,
                style: Theme.of(context).textTheme.labelMedium,
              );
            },
          )),
          SizedBox(
            height: 1.h,
          ),
          const Divider(
            color: commonGreen,
            thickness: 2,
          ),
          CustomListTile(
            title: 'My Courses',
            leadingIcon: CustomIcons.courseIcon,
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const MyCoursesScreen(),
                      type: PageTransitionType.fade));
            },
          ),
          const CustomListTile(
            title: 'Help Centre',
            leadingIcon: CustomIcons.myMessagesIcon,
            isTrailing: false,
          ),
          CustomListTile(
            title: 'Log Out',
            leadingIcon: CustomIcons.myLogOut,
            isTrailing: false,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        "Logging Out",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      titlePadding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      content: Text(
                        "Are you sure?",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontSize: 16.sp),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "No",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: commonGreen),
                            )),
                        TextButton(
                            onPressed: () {
                              context.read<LearnerBloc>().add(LogOutEvent());
                              // Navigator.pushReplacement(context, PageTransition(child: Selection, type: type))
                            },
                            child: Text(
                              "Yes",
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                      ],
                    );
                  });
            },
          ),
          const CustomListTile(
            title: 'Delete Account',
            leadingIcon: CustomIcons.myDeleteAccount,
            isTrailing: false,
          ),
          const CustomListTile(
            title: 'Share App',
            leadingIcon: CustomIcons.myShareApp,
            isTrailing: false,
          ),
          const CustomListTile(
            title: 'Rate Us',
            isTrailing: false,
            iconData: Icons.rate_review_outlined,
          ),
        ],
      ),
    ));
  }
}

class _ImageEdit extends StatelessWidget {
  const _ImageEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: commonGreen, width: 3),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: BlocBuilder<LearnerBloc, LearnerState>(
            builder: (context, state) {
                return CachedNetworkImage(
                  height: 20.h,
                  width: 19.5.h,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  imageUrl: context.read<Repository>().image,
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      foregroundImage: imageProvider,
                    );
                  },
                );
            },
          ),
        ),
        Positioned(
          left: 31.w,
          top: 15.h,
          child: const EditIconStack(),
        ),
      ],
    );
  }
}
