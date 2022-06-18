import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/drop_down.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/custom_widgets/form_field.dart';
import 'package:health_coach/login_signup_feature/signup_form/cubit/first_form_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:health_coach/custom_classes/validator_mixin.dart';

import '../../learner_form/view/learner_form_screen.dart';

class CoachFormScreen extends StatelessWidget {
  const CoachFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirstFormCubit, FirstFormState>(
      listener: (context, state) {
        if (state is RegisterSuccessPopUpCoach) {
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
      child: _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget with InputValidatorMixin {
  _Scaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'We need to know more about your qualifications',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: commonBlack),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomDropDown(
                onChanged: (val) {
                  context.read<FirstFormCubit>().checkQualification(val);
                  return isQualificationValid(val);
                },
              ),
              CustomTextField(
                maxLength: 75,
                textInputAction: TextInputAction.next,
                height: 15.94.h,
                validator: (val) {
                  context.read<FirstFormCubit>().checkStream(val);
                  return isStreamValid(val);
                },
                delay: 200,
                head: 'Streams',
                hintText: 'yoga, aerobics....',
                maxLines: 2,
              ),
              CustomTextField(
                textInputAction: TextInputAction.done,
                height: 22.5.h,
                validator: (val) {
                  context.read<FirstFormCubit>().checkAbout(val);
                  return isAboutValid(val);
                },
                delay: 300,
                head: 'About you',
                hintText: 'A few words about you...',
                maxLines: 5,
              ),
              SizedBox(
                height: 22.h,
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
                    child: ZoomIn(child: const _RegisterButton()),
                  )
                ],
              ),
            ],
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
        if (current is EnableNextButtonCoach ||
            current is DisableNextButtonCoach) {
          return true;
        }
        return false;
      }),
      builder: (context, state) {
        if (state is EnableNextButtonCoach) {
          return CustomElevatedButton(
            voidCallback: () {
              print("presign");
              context.read<FirstFormCubit>().registerSuccessDialogCoach();
            },
            text: 'Register',
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
          );
        } else {
          return const CustomElevatedButton(
              voidCallback: null,
              text: 'Register',
              backgroundColor: Colors.transparent,
              foregroundColor: commonGreen);
        }
      },
    );
  }
}
