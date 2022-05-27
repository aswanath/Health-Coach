import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/elevated_button.dart';
import 'package:health_coach/learner_feature/home/unlocked_course/bloc/buy_course_bloc.dart';
import 'package:hidable/hidable.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class RecommendCourses extends StatelessWidget {
  const RecommendCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuyCourseBloc(),
      child: BlocListener<BuyCourseBloc, BuyCourseState>(
        listener: (context, state) {
          if (state is BuyCourseSuccess) {
            showDialog(
                useRootNavigator: false,
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return _BuySuccessDialog();
                });
          }
        },
        child: _Scaffold(),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  _Scaffold({
    Key? key,
  }) : super(key: key);
  final ScrollController scrollController = ScrollController();

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
              title: _AppBarTitle(),
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
                _CarouselItem(),
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
                  '''In purus at morbi magna in in maecenas. Nunc nulla magna elit, varius phasellus 
Nunc nulla magna elit, varius phasellus blandit convallis. In purus at morbi
magna in in maecenas. Nunc nulla magna elit, varius phasellus blandit convallis.''',
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
                      '₹ 499',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: commonGreen, fontSize: 20.sp),
                    ),
                    CustomElevatedButton(
                      voidCallback: () {
                        context.read<BuyCourseBloc>().add(BuyNowClicked());
                      },
                      text: 'Buy Now',
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 1.2.h),
                    )
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

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/carousel_demo.jpg',
              fit: BoxFit.cover,
              height: 22.h,
              width: 100.w,
            ),
          ),
          Icon(
            Icons.lock_outline_rounded,
            color: commonWhite,
            size: 38.sp,
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: commonGreen),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: commonWhite),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: .25.h),
                  child: Text(
                    'Cardio',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: commonGreen, fontSize: 12.sp),
                  ),
                ),
              ),
            ),
            right: 0,
            bottom: 4.h,
          ),
        ],
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Cardio Hard',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 17.sp)),
        Text(
          'Rajesh Kumar',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(height: .8),
        )
      ],
    );
  }
}

class _BuySuccessDialog extends StatelessWidget {
  const _BuySuccessDialog({
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
                        "Success",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: commonGreen, fontSize: 20.sp),
                      ),
                    ),
                  )
                ],
              ),
              CustomElevatedButton(
                voidCallback: () {
                  Navigator.of(context).pop();
                },
                text: 'Go back',
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
              )
            ],
          ),
        ),
      ),
    );
  }
}
