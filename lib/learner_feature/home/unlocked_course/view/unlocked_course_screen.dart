import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_classes/better_player_configuration.dart';
import 'package:health_coach/custom_widgets/appbar.dart';
import 'package:health_coach/learner_feature/home/model/unlocked_course_model.dart';
import 'package:hidable/hidable.dart';
import 'package:sizer/sizer.dart';

class UnlockedCourse extends StatelessWidget {
  final int heroTag;
  final Workout workout;

  const UnlockedCourse({Key? key, required this.heroTag, required this.workout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Scaffold(
      workout: workout,
    );
  }
}

class _Scaffold extends StatefulWidget {
  final Workout workout;

  _Scaffold({Key? key, required this.workout}) : super(key: key);

  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold> {
  final ScrollController _scrollController = ScrollController();
  late BetterPlayerController _controller;
  late BetterPlayerConfiguration _configuration;

  @override
  dispose() {
    super.dispose();
    _controller.dispose(forceDispose: true);
  }

  @override
  initState() {
    super.initState();
    _configuration = playerConfiguration(image: widget.workout.image, list: [
      BetterPlayerOverflowMenuItem(Icons.download, 'Download', () => null),
    ]);
    _controller = BetterPlayerController(_configuration,
        betterPlayerDataSource: BetterPlayerDataSource.network(
          widget.workout.video,
        ));
  }

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
                title: AppBarTitle(
                  title: widget.workout.workout,
                  author: widget.workout.trainer,
                ),
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
              widget.workout.description,
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
              widget.workout.diet1,
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
