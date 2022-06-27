import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/learner_feature/bloc/learner_bloc.dart';
import 'package:health_coach/learner_feature/home/cubit/carousel_slider_cubit.dart';
import 'package:health_coach/learner_feature/home/model/home_model.dart';
import 'package:health_coach/learner_feature/home/unlocked_course/view/unlocked_course_screen.dart';
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

class _Scaffold extends StatefulWidget {
  final ScrollController scrollController;

  const _Scaffold({
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold>
    with SingleTickerProviderStateMixin {
  late LearnerBloc learnerBloc;
  late AnimationController rotationController;

  @override
  initState() {
    super.initState();
    learnerBloc = context.read<LearnerBloc>();
    learnerBloc.add(LoadBanner());
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        cacheExtent: 0,
        controller: widget.scrollController,
        children: [
          SizedBox(
            height: 2.h,
          ),
          GreetingText(),
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
          Padding(
            padding: EdgeInsets.only(left: 6.w, top: 2.5.h, bottom: 1.h),
            child: const _YourCourseHeader(),
          ),
          _YourCourses(rotationController: rotationController),
          // const HorizontalScrollView(
          //   title: 'Courses you might like',
          //   isUnlocked: false,
          // ),
          SizedBox(
            height: 2.5.h,
          ),
        ],
      ),
    ));
  }
}

class _YourCourses extends StatelessWidget {
  const _YourCourses({
    Key? key,
    required this.rotationController,
  }) : super(key: key);

  final AnimationController rotationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnerBloc, LearnerState>(buildWhen: (prev, cur) {
      if (cur is UnlockedCoursesLoaded ||
          cur is UnlockedCoursesLoading ||
          cur is UnlockedCoursesLoadingFailed) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is UnlockedCoursesLoading) {
        return UnconstrainedBox(
          child: Container(
            height: 5.h,
            width: 5.h,
            child: const CircularProgressIndicator(
              color: commonBlack,
            ),
            margin: EdgeInsets.only(top: 1.h),
          ),
        );
      } else if (state is UnlockedCoursesLoadingFailed) {
        return Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Material(
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0)
                    .animate(rotationController),
                child: IconButton(
                  onPressed: () {
                    rotationController.forward(from: 0.0);
                    context
                        .read<LearnerBloc>()
                        .add(LoadUnlockedCourses());
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: commonBlack.withOpacity(.7),
                    size: 25.sp,
                  ),
                  padding: const EdgeInsets.all(1),
                ),
              ),
              shape: StadiumBorder(
                  side: BorderSide(color: commonBlack.withOpacity(.2))),
              elevation: 5,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Loading Failed! please retry",
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        );
      } else if (state is UnlockedCoursesLoaded) {
        return SizedBox(
          height: 25.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: state.unlockedCourses.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 2.w,
              );
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                child: _HorizontalScrollItem(
                  imagePath: state.unlockedCourses[index].workout.image,
                  header: state.unlockedCourses[index].workout.workout,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: UnlockedCourse(
                            heroTag: index,
                            workout: state.unlockedCourses[index].workout,
                          ),
                          type: PageTransitionType.fade));
                },
              );
            },
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}

class _YourCourseHeader extends StatelessWidget {
  const _YourCourseHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnerBloc, LearnerState>(
      buildWhen: (prev, cur) {
        if (cur is UnlockedCoursesLoaded ||
            cur is UnlockedCoursesLoading ||
            cur is UnlockedCoursesLoadingFailed) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is UnlockedCoursesLoaded &&
            state.unlockedCourses.isEmpty) {
          return const SizedBox();
        } else {
          return Text(
            'Your Courses',
            style: Theme.of(context).textTheme.labelMedium,
          );
        }
      },
    );
  }
}

class HorizontalScrollView extends StatelessWidget {
  final String title;
  final bool isUnlocked;

  const HorizontalScrollView({
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
              return GestureDetector(
                child: const _HorizontalScrollItem(
                  header: "How to get six pack within 6 weeks",
                  imagePath: 'assets/images/carousel_demo.jpg',
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         child: isUnlocked
                  //             ? UnlockedCourse(
                  //                 heroTag: index,
                  //               )
                  //             : const RecommendCourses(),
                  //         type: PageTransitionType.fade));
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class _HorizontalScrollItem extends StatelessWidget {
  final String imagePath;
  final String header;

  const _HorizontalScrollItem(
      {Key? key, required this.imagePath, required this.header})
      : super(key: key);

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
              ),
              color: commonGreen),
          child: ClipRRect(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero, color: commonBlack),
          padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3),
          height: 9.h,
          width: 40.w,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: commonWhite),
            padding: EdgeInsets.symmetric(horizontal: .8.w, vertical: .1.h),
            child: AutoSizeText(
              header,
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

class GreetingText extends StatelessWidget {
  GreetingText({Key? key}) : super(key: key);
  String greeting = '';
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselSliderCubit, CarouselSliderChangedState>(
      builder: (context, state) {
        if (state is GreetingChanged) {
          greeting = state.greeting;
          userName = state.name;
        }
        return Center(
          child: Text(
            'Good $greeting, $userName 👋',
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
          count: 3,
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
          child: BlocBuilder<LearnerBloc, LearnerState>(
            buildWhen: (prev, curr) {
              if (curr is BannerState) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state is BannerState) {
                if (state.status == Status.success) {
                  final _banner = state.banner!;
                  return CarouselSlider(
                    items: [
                      _CarouselItem(
                          imageLink: _banner.image1, headline: _banner.title1),
                      _CarouselItem(
                          imageLink: _banner.image2, headline: _banner.title2),
                      _CarouselItem(
                          imageLink: _banner.image3, headline: _banner.title3),
                    ],
                    options: CarouselOptions(
                      viewportFraction: 1,
                      padEnds: false,
                      autoPlayCurve: Curves.decelerate,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        context.read<CarouselSliderCubit>().changeIndex(index);
                      },
                    ),
                  );
                } else if (state.status == Status.loading) {
                  return Container(
                    color: Colors.green,
                    height: 10.h,
                    width: 80.w,
                  );
                } else {
                  return Container(
                    color: Colors.red,
                    height: 10.h,
                    width: 80.w,
                  );
                }
              } else {
                return SizedBox(
                  child: Text("NO tload"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  final String headline;
  final String imageLink;

  const _CarouselItem({
    required this.imageLink,
    required this.headline,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          imageLink,
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
