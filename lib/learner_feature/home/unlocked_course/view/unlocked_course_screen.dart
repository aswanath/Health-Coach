import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:hidable/hidable.dart';
import 'package:sizer/sizer.dart';

class UnlockedCourse extends StatelessWidget {
  final int heroTag;

  const UnlockedCourse({Key? key, required this.heroTag}) : super(key: key);

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
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: commonGreen, size: 24.sp),
                titleSpacing: 0,
                title: const _AppBarTitle(),
              ),
              controller: _scrollController),
        ),
        body: ListView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            const _CarouselItem(),
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
            Text(
              '''In purus at morbi magna in in maecenas. Nunc nulla magna elit, varius phasellus 
Nunc nulla magna elit, varius phasellus blandit convallis. In purus at morbi
magna in in maecenas. Nunc nulla magna elit, varius phasellus blandit convallis.varius phasellus blandit convallis. In purus at morbi
magna in in maecenas. Nunc nulla magna elit, varius phasellus blandit convallis''',
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
            Icons.play_circle_outline_rounded,
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
