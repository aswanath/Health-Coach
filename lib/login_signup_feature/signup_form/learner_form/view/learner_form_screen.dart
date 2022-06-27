import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/custom_widgets/form_field.dart';
import 'package:health_coach/icons.dart';
import 'package:health_coach/learner_feature/bottom_navigation.dart';
import 'package:health_coach/login_signup_feature/bloc/login_signup_bloc.dart';
import 'package:health_coach/login_signup_feature/signup_form/cubit/first_form_cubit.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:health_coach/custom_classes/validator_mixin.dart';


class LearnerFormScreen extends StatelessWidget {
  const LearnerFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<FirstFormCubit, FirstFormState>(listener: (context, state) {
        if (state is RegisterSuccessPopup) {
          showDialog(
              useRootNavigator: false,
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<FirstFormCubit>(),
                  child: const RegisterSuccessPopupDialog(),
                );
              });
          return;
        }
      }),
      BlocListener<LoginSignupBloc, LoginSignupState>(
          listener: (context, state) {
        if (state is RegisterChecking) {
          showDialog(
              useRootNavigator: false,
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<LoginSignupBloc>(),
                  child: const RegisterCheckingDialog(),
                );
              });
          return;
        }
        if(state is RegisterFailed){
          Navigator.pop(context);
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
          getx.Get.offAll(const BottomNavigationLearnerScreen(),transition: getx.Transition.fadeIn);
        }
      }),
    ], child: _Scaffold());
  }
}

class _Scaffold extends StatelessWidget with InputValidatorMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _Scaffold({
    Key? key,
  }) : super(key: key);

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
                    'We need to know more about You!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: commonBlack),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          onSaved: (val) {
                            context
                                .read<LoginSignupBloc>()
                                .add(LearnerFormEvent(age: int.parse(val!)));
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.number,
                          validator: (val) {
                            context.read<FirstFormCubit>().checkAge(val);
                            return isAgeValid(val);
                          },
                          delay: 100,
                          head: 'Age',
                          hintText: '24',
                          icon: const Iconify(
                            CustomIcons.ageIcon,
                            color: commonGreen,
                          ),
                        ),
                        CustomTextField(
                          onSaved: (val) {
                            context
                                .read<LoginSignupBloc>()
                                .add(LearnerFormEvent(height: int.parse(val!)));
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.number,
                          validator: (val) {
                            context.read<FirstFormCubit>().checkHeight(val);
                            return isHeightValid(val);
                          },
                          delay: 200,
                          head: 'Height',
                          hintText: '172 cm',
                          icon:  const Iconify(
                            CustomIcons.heightIcon,
                            color: commonGreen,
                          ),
                        ),
                        CustomTextField(
                          onSaved: (val) {
                            context
                                .read<LoginSignupBloc>()
                                .add(LearnerFormEvent(weight: int.parse(val!)));
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputType: TextInputType.number,
                          validator: (val) {
                            context.read<FirstFormCubit>().checkWeight(val);
                            return isWeightValid(val);
                          },
                          delay: 300,
                          head: 'Weight',
                          hintText: '68 kg',
                          icon: const Iconify(
                            CustomIcons.weightIcon,
                            color: commonGreen,
                          ),
                        ),
                        CustomTextField(
                          onSaved: (val) {
                            context
                                .read<LoginSignupBloc>()
                                .add(LearnerFormEvent(healthCondition: val));
                            return null;
                          },
                          height: 23.h,
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            context.read<FirstFormCubit>().checkHealth(val);
                            return isHealthValid(val);
                          },
                          delay: 400,
                          head: 'Health Condition',
                          hintText: 'low sugar , no health issues, etc.',
                          maxLines: 5,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 12.h,
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
                    Padding(
                      padding: EdgeInsets.only(right: 1.w),
                      child: _RegisterButton(
                        formKey: _formKey,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  _RegisterButton({
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstFormCubit, FirstFormState>(
      buildWhen: ((previous, current) {
        if (current is EnableNextButtonLearner ||
            current is DisableNextButtonLearner) {
          return true;
        }
        return false;
      }),
      builder: (context, state) {
        if (state is EnableNextButtonLearner) {
          return ZoomIn(
            child: CustomElevatedButton(
              voidCallback: () {
                formKey.currentState!.save();
                context.read<LoginSignupBloc>().add(LearnerRegisterCheck());
              },
              text: 'Register',
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
            ),
          );
        } else {
          return ZoomIn(
            child: CustomElevatedButton(
                voidCallback: () {
                  formKey.currentState!.validate();
                },
                text: 'Register',
                backgroundColor: Colors.transparent,
                foregroundColor: commonGreen),
          );
        }
      },
    );
  }
}

class RegisterSuccessPopupDialog extends StatelessWidget {
  const RegisterSuccessPopupDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          height: 35.h,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  LottieBuilder.asset(
                    'assets/lottie_animation/success_lottie.json',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    height: 25.h,
                    repeat: false,
                  ),
                  Positioned(
                    top: 18.h,
                    child: ElasticIn(
                      duration: const Duration(milliseconds: 2000),
                      child: Text(
                        "Register Success",
                        style: themeData.textTheme.headlineLarge!
                            .copyWith(color: commonGreen, fontSize: 20.sp),
                      ),
                    ),
                  )
                ],
              ),
              CustomElevatedButton(
                voidCallback: () {
                  context.read<FirstFormCubit>().gotToLogin(context);
                },
                text: 'Go to Log In',
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterCheckingDialog extends StatelessWidget {
  const RegisterCheckingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: const CircularProgressIndicator(
              color: commonWhite,
            ),
            height: 5.h,
            width: 5.h,
          ),
          SizedBox(
            height: 2.h,
          ),
          BlocBuilder<LoginSignupBloc, LoginSignupState>(
            builder: (context, state) {
              Widget child = const SizedBox();
              if (state is RegisterChecking) {
                child = Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Registering",
                      style: themeData.textTheme.headlineLarge!
                          .copyWith(color: commonWhite, fontSize: 20.sp),
                    ),
                    SizedBox(
                      width: 8.w,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            '...',
                            textStyle: themeData.textTheme.headlineLarge!
                                .copyWith(
                                color: commonWhite, fontSize: 20.sp),
                            speed: const Duration(milliseconds: 300),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is RegisterSuccess) {
                child = Text(
                  "Register Success",
                  style: themeData.textTheme.headlineLarge!
                      .copyWith(color: commonWhite, fontSize: 20.sp),
                );
              } else if(state is LoggingIn){
                child = Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Logging In",
                      style: themeData.textTheme.headlineLarge!
                          .copyWith(color: commonWhite, fontSize: 20.sp),
                    ),
                    SizedBox(
                      width: 8.w,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            '...',
                            textStyle: themeData.textTheme.headlineLarge!
                                .copyWith(
                                color: commonWhite, fontSize: 20.sp),
                            speed: const Duration(milliseconds: 300),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }
}
