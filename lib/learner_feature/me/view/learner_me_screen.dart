import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/list_tile.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/learner_feature/me/edit_profile/view/profile_edit.dart';
import 'package:health_coach/learner_feature/me/my_courses/view/me_my_courses.dart';
import 'package:health_coach/login_signup_feature/signup_form/first_form/view/first_form_screen.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class LearnerMeScreen extends StatelessWidget {
  const LearnerMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Scaffold();
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
                  child: const _ImageEdit())),
          SizedBox(
            height: 1.h,
          ),
          Align(
              child: Text(
            "Aswanath C K",
            style: Theme.of(context).textTheme.labelMedium,
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
            leadingIcon: CustomIcons.myCoursesIcon,
            transform: -.6,
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const MyCoursesScreen(), type: PageTransitionType.fade));
            },
          ),
          const CustomListTile(
            title: 'Help Centre',
            leadingIcon: CustomIcons.myHelpCenter,
            isTrailing: false,
          ),
          CustomListTile(
            title: 'Log Out',
            leadingIcon: CustomIcons.myLogOut,
            isTrailing: false,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
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
                            onPressed: () {},
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
            leadingIcon: CustomIcons.myRateUs,
            isTrailing: false,
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
          height: 20.h,
          width: 20.h,
          decoration: BoxDecoration(
              border: Border.all(color: commonGreen, width: 3),
              color: Colors.transparent,
              shape: BoxShape.circle,
              image: const DecorationImage(
                  image: AssetImage('assets/images/avatars/four.png'),
                  filterQuality: FilterQuality.high)),
        ),
        Positioned(
          left: 31.w,
          top: 15.h,
          child: const EditIconStack(),
        )
      ],
    );
  }
}
