import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/appbar.dart';
import 'package:health_coach/learner_feature/home/locked_course/view/recommended_courses.dart';
import 'package:hidable/hidable.dart';
import 'package:sizer/sizer.dart';

class BlogReadDetails extends StatelessWidget {
  const BlogReadDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Scaffold();
  }
}

class _Scaffold extends StatelessWidget {
   _Scaffold({
    Key? key,
  }) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(100.w, 6.5.h),
          child: Hidable(
            controller: _scrollController,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: commonGreen, size: 24.sp),
              titleSpacing: 0,
              title: const AppBarTitle(title: 'How to become healthy', author: 'Jagatheesh'),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          children: [
            SizedBox(height: 2.h,),
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/carousel_demo.jpg',
                  fit: BoxFit.cover,
                  height: 25.h,
                  width: 90.w,
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Text(
              '''In purus at morbi magna in in maecenas. Nunc nulla magna elit, varius phasellus 
Nunc nulla magna elit, varius phasellus blandit convallis. In purus at morbi
magna in in maecenas. Nunc nulla magna elit, varius phasellus blandit convallis.''',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
