import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_coach/coach_feature/home/user/view/user_details.dart';
import 'package:health_coach/learner_feature/explore/blog_details/view/blog_read_details.dart';
import 'package:health_coach/learner_feature/explore/view/learner_explore_screen.dart';
import 'package:health_coach/learner_feature/home/cubit/carousel_slider_cubit.dart';
import 'package:health_coach/learner_feature/home/view/learner_home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class CoachHomeScreen extends StatelessWidget {
  final ScrollController scrollController;

  const CoachHomeScreen({Key? key, required this.scrollController})
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

  const _Scaffold({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          cacheExtent: 1000,
          controller: scrollController,
          children: [
            SizedBox(
              height: 2.h,
            ),
            GreetingText(
              name: 'Coach',
            ),
            HorizontalScrollView(isUnlocked: true, title: 'Your Courses'),
            Padding(
              padding: EdgeInsets.only(left: 6.w, top: 2.5.h, bottom: 1.h),
              child: Text(
                'Your Users',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            CoachHorizontalScrollView(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const UserDetailsScreen(),
                        type: PageTransitionType.fade));
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.w, top: 2.5.h, bottom: 1.h),
              child: Text(
                'Your Blogs',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(
              height: 23.h,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const BlogReadDetails(),
                                  type: PageTransitionType.fade));
                        },
                          child: BlogCustomItem(
                        description: 'index' * (index + 1),
                        maxLines: 2,
                      )),
                    );
                  }),
            ),
            SizedBox(
              height: 1.h,
            )
          ],
        ),
      ),
    );
  }
}
