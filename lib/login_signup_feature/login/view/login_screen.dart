import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/admin_feature/home/home.dart';
import 'package:health_coach/coach_feature/home/home_screen.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/custom_widgets/form_field.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/learner_feature/bottom_navigation.dart';
import 'package:health_coach/login_signup_feature/cubit/login_signup_cubit.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:health_coach/custom_classes/validator_mixin.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginSignupCubit(),
      child: BlocListener<LoginSignupCubit, LoginSignupState>(
        listener: (context, state) {
          if (state is PopBack) {
            Navigator.pop(context);
            return;
          }
          if (state is UserTypeNavigation) {
            if (state.userType == UserType.learner) {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const BottomNavigationLearnerScreen(),
                      type: PageTransitionType.fade),
                      (route) => false);
            } else if (state.userType == UserType.coach) {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const CoachHomeScreen(),
                      type: PageTransitionType.fade),
                      (route) => false);
            } else if (state.userType == UserType.admin) {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const AdminHomeScreen(),
                      type: PageTransitionType.fade),
                      (route) => false);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Invalid User Credentials',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 12.sp)),
                backgroundColor: Colors.red,
                margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ));
            }
            return;
          }
        },
        child: _Scaffold(),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget with InputValidatorMixin {
  _Scaffold({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Text(
                    'Welcome !',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: commonBlack, fontSize: 22.sp),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textEditingController: emailTextEditingController,
                          validator: (val) {
                            return isEmailValid(val);
                          },
                          delay: 100,
                          head: 'Email id',
                          hintText: 'John123@gmail.com',
                          icon: const Iconify(
                            CustomIcons.emailIcon,
                            color: commonGreen,
                          ),
                        ),
                        CustomTextField(
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: (val) {
                            return isPasswordValid(val);
                          },
                          delay: 200,
                          head: 'Password',
                          hintText: '********',
                          icon: const Iconify(
                            CustomIcons.passwordIcon,
                            color: commonGreen,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ZoomIn(
                      child: CustomElevatedButton(
                          voidCallback: () {
                            context.read<LoginSignupCubit>().popBack();
                          },
                          text: 'Back',
                          backgroundColor: Colors.transparent,
                          foregroundColor: commonGreen),
                    ),
                    ZoomIn(
                      child: CustomElevatedButton(
                        voidCallback: () {
                          context.read<LoginSignupCubit>().navigateToWhere(
                              _globalKey, emailTextEditingController.text);
                        },
                        text: "Log In",
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 1.2.h),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 3.h),
                    width: 50.w,
                    child: Text(
                      "By logging in you accept our Terms & Conditions",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
