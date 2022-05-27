import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class LearnerExploreScreen extends StatelessWidget {
  final ScrollController scrollController;

  const LearnerExploreScreen({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Scaffold(
      scrollController: scrollController,
    );
  }
}

class _Scaffold extends StatelessWidget {
  final ScrollController scrollController;

  _Scaffold({
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        controller: scrollController,
        children: [
          SizedBox(
            height: 2.h,
          ),
          SlideInLeft(
            child: Padding(
              padding:  EdgeInsets.only(left: 4.w),
              child: Text.rich(TextSpan(
                  text: 'Health',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 20.sp, color: commonGreen),
                  children: [
                    TextSpan(
                      text: ' Blogs',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 20.sp),
                    )
                  ])),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding:  EdgeInsets.only(left: 4.w,right: 4.w),
            child: StaggeredGridView.builder(
              shrinkWrap: true,
              itemCount: 10,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return FadeInDown(
                  delay: Duration(milliseconds: index * 100),
                  duration: const Duration(milliseconds: 500),
                  child: _BlogCustomItem(
                    description: 'Hello ' * ((index + 1) * 4),
                  ),
                );
              },
              gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                staggeredTileBuilder: (int index) {
                  return const StaggeredTile.fit(1);
                },
                crossAxisCount: 2,
                mainAxisSpacing: 1.5.h,
                crossAxisSpacing: 5.w,
                staggeredTileCount: 10,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 4.w),
            child: Text.rich(TextSpan(
                text: 'Health',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 20.sp, color: commonGreen),
                children: [
                  TextSpan(
                    text: ' Coaches',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 20.sp),
                  )
                ])),
          ),
          SizedBox(
            height: 2.h,
          ),
           SizedBox(
             height: 32.h,
             child: ListView.builder(
                 padding:  EdgeInsets.only(left: 4.w,right: 1.w),
               itemCount: 10,
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context,index){
               return Padding(
                 padding:  EdgeInsets.only(right: 3.w),
                 child: _CoachItem(),
               );
             }),
           ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    ));
  }
}

class _CoachItem extends StatelessWidget {
  const _CoachItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          _StackElementCoach(),
          Container(
            padding: EdgeInsets.only(
                left: 2.5.w, right: 2.w, top: .5.h, bottom: 1.5.h),
            height: 32.h,
            width: 50.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent),
            child: Column(
              children: [
                SizedBox(height: 2.h,),
                Stack(
                  children: [
                    Container(
                      height: 10.h,
                      width: 10.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: commonBlack, width: 1),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(avatarList[2]),
                              filterQuality: FilterQuality.high)),
                    ),
                    CustomPaint(
                      size: Size(10.h, 10.h),
                      painter: HalfCircle(),
                    )
                  ],
                ),
                SizedBox(height: 1.h,),
                Text('Aswanath C K',style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14.sp),),
                Text('Yoga Coach',style: Theme.of(context).textTheme.labelSmall,),
                SizedBox(height: 1.h,),
                Text(
                  '''I am very passionate about my courses and I love to teach everyone.''',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HalfCircle extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
        ..strokeWidth = 3
      ..style= PaintingStyle.stroke
    ..color = commonGreen;

    canvas.drawArc(Rect.fromCenter(
      center: Offset(size.height / 2, size.width / 2),
      height: size.height*1.1,
      width: size.width*1.1,
    ), 4.5, 4.5, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _StackElementCoach extends StatelessWidget {
  const _StackElementCoach({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 32.h,
          width: 50.w,
          decoration: BoxDecoration(
              color: commonWhite,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: commonGreen, width: 2.w)),
        ),
        Container(
          padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w, bottom: 1.5.w),
          height: 25.h,
          width: 50.w,
          decoration: const BoxDecoration(
              color: commonWhite,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        )
      ],
    );
  }
}

class _BlogCustomItem extends StatelessWidget {
  final String description;

  const _BlogCustomItem({
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 43.w,
          child: Column(
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/images/carousel_demo.jpg',
                  width: 43.w,
                  height: 12.h,
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 43.w,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: commonWhite),
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.2.w, vertical: .5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'How to get six pac'
                        'k within 6 weeks',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: commonGreen, height: .9.sp),
                        minFontSize: 12,
                        maxFontSize: 17,
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      AutoSizeText(
                        description,
                        style: Theme.of(context).textTheme.labelMedium,
                        minFontSize: 10,
                        maxFontSize: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
