import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/appbar.dart';
import 'package:health_coach/custom_widgets/custom_circle_avatar.dart';
import 'package:health_coach/learner_feature/explore/view/learner_explore_screen.dart';
import 'package:health_coach/learner_feature/home/view/learner_home_screen.dart';
import 'package:hidable/hidable.dart';
import 'package:sizer/sizer.dart';

class CoachReadDetails extends StatelessWidget {
  const CoachReadDetails({Key? key}) : super(key: key);

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
            title: const AppBarTitle(),
          ),
        ),
      ),
      body: ListView(
        children: [
          Align(
            child: Stack(
              children: [
                Container(
                  height: 18.h,
                  width: 18.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: commonBlack, width: 1),
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(avatarList[2]),
                          filterQuality: FilterQuality.high)),
                ),
                CustomPaint(
                  size: Size(18.h, 18.h),
                  painter: HalfCircle(),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h,),
          Align(child: Text("Aswanath C K",style: Theme.of(context).textTheme.labelMedium,)),
          SizedBox(height: 1.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 6.w),
            child: _StreamChips(),
          ),
          SizedBox(height: 2.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 6.w),
            child: Text(
              '''In purus at morbi magna in in maecenas. Nunc nulla magna elit, varius phasellus 
Nunc nulla magna elit''',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 14.sp),
            ),
          ),
          const HorizontalScrollView(isUnlocked: false, title: 'Courses')
        ],
      ),
    ));
  }
}

class _StreamChips extends StatelessWidget {
   _StreamChips({
    Key? key,
  }) : super(key: key);
  final List<String> streamList = ["yoga","Meditation","Circuit training","Cardio"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: -8,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.end,
      children: List.generate(
          4,
          (index) => Padding(
            padding:  EdgeInsets.symmetric(horizontal: 1.w),
            child: Chip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  label: Text(
                    streamList[index],
                    style: GoogleFonts.nunito(color: commonWhite,fontSize: 12.sp,fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: commonGreen,
                ),
          )),
    );
  }
}
