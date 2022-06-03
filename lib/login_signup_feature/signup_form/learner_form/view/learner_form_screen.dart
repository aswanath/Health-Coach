import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/custom_widgets/form_field.dart';
import 'package:health_coach/icons.dart';
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
    return BlocListener<FirstFormCubit, FirstFormState>(
      listener: (context, state) {
        if (state is PopBackLearner) {
          Navigator.pop(context);
        }
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
        }
      },
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget with InputValidatorMixin {
  const _Scaffold({
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
                CustomTextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputType: TextInputType.number,
                  validator: (val) {
                    context.read<FirstFormCubit>().checkHeight(val);
                    return isHeightValid(val);
                  },
                  delay: 200,
                  head: 'Height',
                  hintText: '172 cm',
                  icon: const Iconify(
                    CustomIcons.heightIcon,
                    color: commonGreen,
                  ),
                ),
                CustomTextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  textInputAction: TextInputAction.done,
                  height: 19.94.h,
                  validator: (val) {
                    return null;
                  },
                  delay: 400,
                  head: 'Health Condition',
                  hintText: 'low sugar , no health issues, etc.',
                  maxLines: 5,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ZoomIn(
                      child: CustomElevatedButton(
                          voidCallback: () {
                            context.read<FirstFormCubit>().popBackLearner();
                          },
                          text: 'Back',
                          backgroundColor: Colors.transparent,
                          foregroundColor: commonGreen),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 1.w),
                      child: const _RegisterButton(),
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
  const _RegisterButton({
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
                context.read<FirstFormCubit>().registerSuccessDialog();
              },
              text: 'Register',
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
            ),
          );
        } else {
          return ZoomIn(
            child: const CustomElevatedButton(
                voidCallback: null,
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
      onWillPop: ()async{
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
