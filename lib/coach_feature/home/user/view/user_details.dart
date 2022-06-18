import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:health_coach/custom_widgets/custom_circle_avatar.dart';
import 'package:hidable/hidable.dart';
import 'package:sizer/sizer.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

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
            child: AppBar(),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          controller: _scrollController,
          children: [
            SizedBox(height: 1.5.h,),
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
            Align(child: Text("No issues",style: Theme.of(context).textTheme.labelSmall,),),
            SizedBox(height: 2.h,),
            Column(
              children: [
                _KeyValueDetail(title: "Email",value: "aswanathck.ramesh@gmail.com",),
                _KeyValueDetail(title: "Age", value: "19"),
                _KeyValueDetail(title: "Weight", value: "68"),
                _KeyValueDetail(title: "Height", value: "175")
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class _KeyValueDetail extends StatelessWidget {
  final String title;
  final String value;
  const _KeyValueDetail({
    Key? key,
  required this.title,
    required this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
      child: Row(
        children: [
          Expanded(child: Text(title,style: Theme.of(context).textTheme.labelLarge,),flex: 1,),
          Expanded(child: Text(": $value",style: Theme.of(context).textTheme.labelLarge,),flex: 4,)
        ],
      ),
    );
  }
}
