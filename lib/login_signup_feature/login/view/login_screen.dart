
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/custom_widgets/form_field.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/internet_connection/internet_bloc.dart';
import 'package:health_coach/learner_feature/bottom_navigation.dart';
import 'package:health_coach/login_signup_feature/bloc/login_signup_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:health_coach/custom_classes/validator_mixin.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginSignupBloc(),
      child: BlocListener<LoginSignupBloc, LoginSignupState>(
        listener: (context, state) {
          if (state is LoginFailed) {
            getx.Get.closeAllSnackbars();
            getx.Get.rawSnackbar(
              duration: const Duration(seconds: 2),
              borderRadius: 10,
              margin: const EdgeInsets.all(5),
              message: state.errorMessage,
              snackPosition: getx.SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
            );
            return;
          }
          if(state is LoginSuccess){
            if(state.userType==UserType.Learner){
              getx.Get.offAll(const BottomNavigationLearnerScreen(),transition: getx.Transition.fadeIn);
            }
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
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  UserType loginType = UserType.Learner;

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
                  child: BlocBuilder<LoginSignupBloc, LoginSignupState>(
                    buildWhen: (prev, curr) {
                      if (curr is TypeOfLogin) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      state as TypeOfLogin;
                      loginType = state.userType;
                      return Text(
                        '${loginType.name} Login',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: commonBlack, fontSize: 22.sp),
                      );
                    },
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
                        textEditingController: _emailTextEditingController,
                        validator: (val) {
                          return isUserNameValid(val);
                        },
                        delay: 100,
                        head: 'Username',
                        hintText: 'john123',
                        icon: const Iconify(
                          CustomIcons.emailIcon,
                          color: commonGreen,
                        ),
                      ),
                      CustomTextField(
                        textEditingController: _passwordTextEditingController,
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
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ZoomIn(
                      child: CustomElevatedButton(
                          voidCallback: () {
                            Navigator.pop(context);
                          },
                          text: 'Back',
                          backgroundColor: Colors.transparent,
                          foregroundColor: commonGreen),
                    ),
                    ZoomIn(
                      child: BlocBuilder<LoginSignupBloc, LoginSignupState>(
                        builder: (context, state) {
                          if (state is LoginChecking) {
                            return CustomElevatedButton(
                              voidCallback: null,
                              text: '',
                              child: const CircularProgressIndicator(
                                color: commonWhite,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: .95.h),
                            );
                          } else {
                            return CustomElevatedButton(
                              voidCallback: () {
                                if (_globalKey.currentState!.validate()) {
                                  context
                                      .read<LoginSignupBloc>()
                                      .add(
                                          LoginUserCheck(
                                              password:
                                                  _passwordTextEditingController
                                                      .text,
                                              username:
                                                  _emailTextEditingController
                                                      .text,
                                              userType: loginType));
                                }
                              },
                              text: "Log In",
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 1.2.h),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: BlocBuilder<LoginSignupBloc, LoginSignupState>(
                    buildWhen: (prev, curr) {
                      if (curr is TypeOfLogin) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      state as TypeOfLogin;
                      final firstText = state.list[0];
                      final secondText = state.list[1];
                      return Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "Login as ",
                              style: GoogleFonts.nunito(fontSize: 12.sp)),
                          TextSpan(
                              text: firstText.name,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<LoginSignupBloc>().add(
                                      SelectLoginType(userType: firstText));
                                },
                              style: GoogleFonts.nunito(
                                  color: commonGreen,
                                  fontSize: 14.sp,
                                  decoration: TextDecoration.underline)),
                          TextSpan(text: "  / ", style: GoogleFonts.nunito()),
                          TextSpan(
                              text: secondText.name,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<LoginSignupBloc>().add(
                                      SelectLoginType(userType: secondText));
                                },
                              style: GoogleFonts.nunito(
                                  color: commonGreen,
                                  fontSize: 14.sp,
                                  decoration: TextDecoration.underline)),
                        ]),
                      );
                    },
                  ),
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
