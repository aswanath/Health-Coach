import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/icons.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

class CoachCreateScreen extends StatelessWidget {
  const CoachCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Scaffold();
  }
}

class _Scaffold extends StatelessWidget {
  _Scaffold({
    Key? key,
  }) : super(key: key);
  final bool _isCourse = sharedPreferences.getBool("isCourse")!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isCourse ? _CourseBody() : _BlogBody(),
      ),
    );
  }
}

class _BlogBody extends StatelessWidget {
  const _BlogBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("blog");
  }
}

class _CourseBody extends StatelessWidget {
  const _CourseBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 5.h,),
        Align(
          child: Container(
            height: 20.h,
            width: 70.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: commonWhite,
              boxShadow: const[
                 BoxShadow(
                  color: Colors.black12,
                  offset: Offset(4, 4),
                  blurRadius: 5,
                )
              ],
                border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(11)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Iconify(CustomIcons.courseIcon,size: 52.sp,color: Colors.grey,),
                Text(
                  "Click to upload video",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.grey, fontSize: 14.sp),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
