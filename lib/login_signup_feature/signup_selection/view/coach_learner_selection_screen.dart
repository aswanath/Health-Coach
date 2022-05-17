import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/login_signup_feature/signup_selection/cubit/coach_learner_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';

import '../../../theme/theme.dart';

class CoachLearnerSelection extends StatelessWidget {
  CoachLearnerSelection({Key? key}) : super(key: key);

  AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoachLearnerCubit(),
      child: Builder(builder: (context) {
        return BlocListener<CoachLearnerCubit, CoachLearnerState>(
          listener: (context, state) {
            if(state is NotSelectedState){
              animationController!.reset();
              animationController!.forward();
            }
          },
          child: SafeArea(
            child: Scaffold(
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Bounce(
                      animate: false,
                      manualTrigger: true,
                      controller: (controller) {
                        animationController = controller;
                      },
                      child: SlideInDown(
                        child: Text(
                          'Select any of the below',
                          style: themeData.textTheme.headlineMedium!
                              .copyWith(color: commonBlack),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.5.w, vertical: 8.h),
                      child: Row(
                        children: [
                          SlideInLeft(child: const _Coach()),
                          SizedBox(
                            width: 3.w,
                          ),
                          SlideInRight(child: const _Learner()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ZoomIn(
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<CoachLearnerCubit>()
                                    .popBack(context);
                              },
                              icon: const Icon(Icons.arrow_back_rounded),
                              splashRadius: 0.01,
                            ),
                          ),
                          ZoomIn(child: const _NextIconButton())
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _NextIconButton extends StatelessWidget {
  const _NextIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachLearnerCubit, CoachLearnerState>(
      buildWhen: ((previous, current) {
        if (current is CoachSelectedState ||
            current is LearnerSelectedState) {
          return true;
        }
        return false;
      }),
      builder: (context, state) {
        Color containerColor = commonWhite;
        Color iconColor = commonGreen;
        double scale = .9;
        if (state is! CoachLearnerInitial) {
          containerColor = commonGreen;
          iconColor = commonWhite;
          scale = 1.1;
        }
        return AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: scale,
          child: AnimatedContainer(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: containerColor,
                border: Border.all(color: iconColor),
                borderRadius: BorderRadius.circular(20)),
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              onPressed: () {
                context.read<CoachLearnerCubit>().navigateToNextScreen(context);
              },
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: iconColor,
              ),
              splashRadius: .01,
            ),
          ),
        );
      },
    );
  }
}

class _Learner extends StatelessWidget {
  const _Learner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachLearnerCubit, CoachLearnerState>(
      builder: (context, state) {
        Color containerColor = commonWhite;
        Color textColor = commonBlack;
        Color borderColor = commonGreen;
        double scale = 1;
        if (state is LearnerSelectedState) {
          containerColor = commonGreen;
          textColor = borderColor = commonWhite;
          scale = 1.05;
        } else {
          containerColor = commonWhite;
          textColor = commonBlack;
          borderColor = commonGreen;
          scale = 1;
        }
        return _Option(
          scale: scale,
          borderColor: borderColor,
          onTap: () {
            context.read<CoachLearnerCubit>().learnerSelect();
          },
          text:
              'If you wish to learn from a professional to become a healthy person.',
          header: 'Learner',
          imagePath: 'assets/images/icons/learner.png',
          textColor: textColor,
          containerColor: containerColor,
        );
      },
    );
  }
}

class _Coach extends StatelessWidget {
  const _Coach({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoachLearnerCubit, CoachLearnerState>(
      builder: (context, state) {
        Color containerColor = commonWhite;
        Color textColor = commonBlack;
        Color borderColor = commonGreen;
        double scale = 1;
        if (state is CoachSelectedState) {
          containerColor = commonGreen;
          textColor = borderColor = commonWhite;
          scale = 1.05;
        } else {
          containerColor = commonWhite;
          textColor = commonBlack;
          borderColor = commonGreen;
          scale = 1;
        }
        return _Option(
            scale: scale,
            borderColor: borderColor,
            onTap: () {
              context.read<CoachLearnerCubit>().coachSelect();
            },
            containerColor: containerColor,
            textColor: textColor,
            text:
                'If you are a great coach and can teach others to lead a healthy life.',
            header: 'Coach',
            imagePath: 'assets/images/icons/coach.png');
      },
    );
  }
}

class _Option extends StatelessWidget {
  final String imagePath;
  final String text;
  final String header;
  final Color containerColor;
  final Color textColor;
  final VoidCallback onTap;
  final Color borderColor;
  final double scale;

  const _Option(
      {Key? key,
      required this.text,
      required this.header,
      required this.imagePath,
      required this.containerColor,
      required this.onTap,
      required this.borderColor,
      required this.scale,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 300),
        child: AnimatedContainer(
          height: 45.h,
          width: 45.w,
          decoration: BoxDecoration(
              color: containerColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(11)),
          duration: const Duration(milliseconds: 300),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Image.asset(
                imagePath,
                height: 8.h,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                header,
                style: themeData.textTheme.headlineLarge!
                    .copyWith(color: textColor),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 3.h),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: themeData.textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.normal,
                      height: .9.sp,
                      letterSpacing: .6.sp,
                      color: textColor,
                      fontSize: 16.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
