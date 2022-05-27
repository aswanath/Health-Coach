import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/learner_feature/home/cubit/carousel_slider_cubit.dart';
import 'package:health_coach/learner_feature/home/model/home_model.dart';
import 'package:health_coach/learner_feature/home/unlocked_course/view/unlocked_course_screen.dart';
import 'package:health_coach/learner_feature/locked_course/view/recommended_courses.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LearnerHomeScreen extends StatelessWidget {
  final ScrollController scrollController;

  const LearnerHomeScreen({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => CarouselSliderCubit()..greetingChange()),
        ],
        child: _Scaffold(
          scrollController: scrollController,
        ));
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
        cacheExtent: 1000,
        controller: scrollController,
        children: [
          SizedBox(
            height: 2.h,
          ),
          _GreetingText(),
          SizedBox(height: 2.5.h),
          const _Carousel(),
          SizedBox(
            height: 1.h,
          ),
          const _CarouselIndicator(),
          SizedBox(
            height: 2.h,
          ),
          const _WeightGraph(),
          _HorizontalScrollView(
            title: 'Your Courses',
            isUnlocked: true,
          ),
          _HorizontalScrollView(title: 'Courses you might like',isUnlocked: false,),
          SizedBox(
            height: 2.5.h,
          ),
        ],
      ),
    ));
  }
}

class _HorizontalScrollView extends StatelessWidget {
  final String title;
  final bool isUnlocked;

  const _HorizontalScrollView({
    required this.isUnlocked,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 2.5.h, bottom: 1.h),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        SizedBox(
          height: 25.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 10,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 2.w,
              );
            },
            itemBuilder: (context, index) {
              return GestureDetector(child:  _HorizontalScrollItem(),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> isUnlocked?UnlockedCourse(heroTag: index,):RecommendCourses()));
              },);
            },
          ),
        )
      ],
    );
  }
}

class _HorizontalScrollItem extends StatelessWidget {
  const _HorizontalScrollItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          width: 40.w,
          height: 25.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: commonGreen),
          child: ClipRRect(
            child: Image.asset(
              'assets/images/carousel_demo.jpg',
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              color: commonBlack),
          padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3),
          height: 9.h,
          width: 40.w,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20)),
                color: commonWhite),
            padding: EdgeInsets.symmetric(horizontal: .8.w, vertical: .1.h),
            child: AutoSizeText(
              'How to get six pac'
              'k within 6 weeks',
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 3,
              minFontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _WeightGraph extends StatelessWidget {
  const _WeightGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: 95.w,
        height: 32.h,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              labelPlacement: LabelPlacement.onTicks,
              tickPosition: TickPosition.inside,
              visibleMaximum: 4),
          title: ChartTitle(
              text: 'Weight Progress',
              alignment: ChartAlignment.near,
              textStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 13.sp)),
          legend: Legend(
              itemPadding: 0,
              isVisible: true,
              position: LegendPosition.top,
              alignment: ChartAlignment.far,
              legendItemBuilder:
                  (String name, dynamic series, dynamic point, int index) {
                return Container(
                  height: 2.h,
                  width: 18.w,
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8.sp,
                        color: index == 0 ? commonGreen : commonBlack,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        index == 0 ? 'Target' : 'Achieved',
                        style: GoogleFonts.nunito(fontSize: 9.sp),
                      )
                    ],
                  ),
                );
              }),
          plotAreaBorderWidth: 0,
          series: <SplineSeries<WeightData, String>>[
            SplineSeries<WeightData, String>(
                name: 'Achieved',
                color: commonBlack,
                dataSource: [
                  WeightData('Jan 2020', 40),
                  WeightData('Feb 2020', 41),
                  WeightData('Mar 2020', 40),
                  WeightData('Apr 2020', 43),
                  WeightData('May 2020', 46),
                  WeightData('June 2020', 46),
                  WeightData('July 2020', 47),
                ],
                xValueMapper: (WeightData weightData, _) => weightData.month,
                yValueMapper: (WeightData weightData, _) => weightData.weight),
            SplineSeries<WeightData, String>(
                name: 'Target',
                color: commonGreen,
                dataSource: [
                  WeightData('Jan 2020', 40),
                  WeightData('Feb 2020', 43),
                  WeightData('Mar 2020', 46),
                  WeightData('Apr 2020', 49),
                  WeightData('May 2020', 52),
                  WeightData('June 2020', 55),
                  WeightData('July 2020', 58),
                ],
                xValueMapper: (WeightData weightData, _) => weightData.month,
                yValueMapper: (WeightData weightData, _) => weightData.weight)
          ],
        ),
      ),
    );
  }
}

class _GreetingText extends StatelessWidget {
  _GreetingText({
    Key? key,
  }) : super(key: key);
  String greeting = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselSliderCubit, CarouselSliderChangedState>(
      builder: (context, state) {
        print("coming here");
        greeting = '';
        if (state is GreetingChanged) {
          greeting = state.greeting;
        }
        return Center(
          child: Text(
            'Good $greeting, Aswanath 👋',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: commonBlack),
          ),
        );
      },
      buildWhen: (previous, current) {
        if (current is GreetingChanged) {
          return true;
        } else {
          return false;
        }
      },
    );
  }
}

class _CarouselIndicator extends StatelessWidget {
  const _CarouselIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        child: BlocBuilder<CarouselSliderCubit, CarouselSliderChangedState>(
      builder: (context, state) {
        int indexOf = 0;
        if (state is CarouselChanged) {
          indexOf = state.index;
        }
        return AnimatedSmoothIndicator(
          activeIndex: indexOf,
          count: 4,
          effect: WormEffect(
              activeDotColor: commonGreen,
              dotColor: Colors.grey.withOpacity(.6),
              dotWidth: 8.sp,
              dotHeight: 8.sp),
        );
      },
    ));
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: 88.w,
        height: 22.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CarouselSlider(
              items: const [
                _CarouselItem(
                  headline: 'Be younger with Yoga',
                ),
                _CarouselItem(
                  headline: 'How to loss fat',
                ),
                _CarouselItem(headline: 'Six pack in 4 weeks'),
                _CarouselItem(
                  headline: 'This will help you stay longer',
                ),
              ],
              options: CarouselOptions(
                  viewportFraction: 1,
                  padEnds: false,
                  autoPlayCurve: Curves.decelerate,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    context.read<CarouselSliderCubit>().changeIndex(index);
                  })),
        ),
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  final String headline;

  const _CarouselItem({
    required this.headline,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          'assets/images/carousel_demo.jpg',
          fit: BoxFit.cover,
          height: 22.h,
          width: 100.w,
        ),
        ClipRRect(
          child: SizedBox(
            height: 6.h,
            width: 100.w,
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: FittedBox(
                    child: Text(
                      headline,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 16.sp),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
