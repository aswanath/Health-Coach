import 'package:animate_do/animate_do.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_classes/better_player_configuration.dart';
import 'package:health_coach/custom_widgets/appbar.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/learner_feature/bloc/learner_bloc.dart';
import 'package:health_coach/learner_feature/home/model/locked_courses_model.dart';
import 'package:health_coach/learner_feature/home/unlocked_course/bloc/buy_course_bloc.dart';
import 'package:hidable/hidable.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class RecommendCourses extends StatelessWidget {
  final LockedCourses lockedCourse;

  const RecommendCourses({Key? key, required this.lockedCourse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LearnerBloc, LearnerState>(
      listener: (context, state) {
        if (state is CourseBuyState) {
          if (state.status == Status.success) {
            Navigator.pop(context);
            showDialog(
                useRootNavigator: false,
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return _BuySuccessDialog(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context,true);
                    },
                  );
                });
          } else if (state.status == Status.fail) {
            Navigator.pop(context);
            showDialog(
                useRootNavigator: false,
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return _BuyFailureDialog(onPressed: () {
                    context
                        .read<LearnerBloc>()
                        .add(CourseBuyEvent(lockedCourse: lockedCourse));
                  });
                });
          } else if (state.status == Status.preLoading) {
            showDialog(
                useRootNavigator: false,
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return WillPopScope(
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: commonGreen,
                      )),
                      onWillPop: () => Future.value(false));
                });
          } else {
            Navigator.pop(context);
          }
        }
      },
      child: _Scaffold(
        lockedCourse: lockedCourse,
      ),
    );
  }
}

class _Scaffold extends StatefulWidget {
  final LockedCourses lockedCourse;

  _Scaffold({
    Key? key,
    required this.lockedCourse,
  }) : super(key: key);

  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold> {
  final ScrollController scrollController = ScrollController();
  late BetterPlayerController _controller;
  late BetterPlayerConfiguration _configuration;

  @override
  initState() {
    super.initState();
    _configuration = playerConfiguration(image: widget.lockedCourse.dietimage);
    _controller = BetterPlayerController(_configuration,
        betterPlayerDataSource:
            BetterPlayerDataSource.network(widget.lockedCourse.preview));
  }

  @override
  dispose() {
    _controller.dispose(forceDispose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(100.w, 6.5.h),
          child: Hidable(
            controller: scrollController,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: commonGreen, size: 24.sp),
              titleSpacing: 0,
              title: AppBarTitle(
                  title: widget.lockedCourse.workout,
                  author: widget.lockedCourse.trainer),
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Preview",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 1.h,
                ),
                ClipRRect(
                  child: BetterPlayer(controller: _controller),
                  borderRadius: BorderRadius.circular(20),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Text(
                  widget.lockedCourse.description,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Diet Plan 🍉",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Container(
                  width: 100.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.grey,
                        size: 80.sp,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: Text(
                          "Buy this course to unlock",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.grey, fontSize: 18.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Hidable(
              controller: scrollController,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                width: 100.w,
                height: 9.h,
                color: commonWhite.withOpacity(.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${widget.lockedCourse.price}',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: commonGreen, fontSize: 20.sp),
                    ),
                    CustomElevatedButton(
                      voidCallback: () {
                        context.read<LearnerBloc>().add(
                            CourseBuyEvent(lockedCourse: widget.lockedCourse));
                      },
                      text: 'Buy Now',
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 1.2.h),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuySuccessDialog extends StatelessWidget {
  final VoidCallback onPressed;

  const _BuySuccessDialog({
    Key? key,
    required this.onPressed,
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
                        "Payment Success",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: commonGreen, fontSize: 18.sp),
                      ),
                    ),
                  )
                ],
              ),
              CustomElevatedButton(
                voidCallback: onPressed,
                text: 'Go Home',
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BuyFailureDialog extends StatelessWidget {
  final VoidCallback onPressed;

  const _BuyFailureDialog({
    Key? key,
    required this.onPressed,
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
          height: 29.5.h,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  LottieBuilder.asset(
                    'assets/lottie_animation/payment_lottie.json',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    height: 15.5.h,
                    repeat: false,
                  ),
                  Positioned(
                    top: 11.5.h,
                    child: ElasticIn(
                      duration: const Duration(milliseconds: 2000),
                      child: Text(
                        'Payment Failed',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.red, fontSize: 20.sp),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomElevatedButton(
                backgroundColor: Colors.red,
                voidCallback: onPressed,
                text: "Retry",
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
              ),
              CustomElevatedButton(
                voidCallback: () {
                  Navigator.pop(context);
                },
                text: 'Go Back',
                backgroundColor: Colors.transparent,
                foregroundColor: commonBlack,
                fontSize: 12.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
