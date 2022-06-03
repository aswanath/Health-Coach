import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:sizer/sizer.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Scaffold();
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100.w, 11.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 26.sp,
                  )),
              SizedBox(
                width: 80.w,
                child: TextField(
                  cursorColor: commonGreen,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    hintText: 'Search for courses',
                    hintStyle: GoogleFonts.nunito(
                        color: Colors.grey[400], fontSize: 12.sp),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    suffixIcon: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: commonGreen,
                          radius: 12.sp,
                        ),
                        Icon(
                          Icons.search_rounded,
                          color: commonWhite,
                          size: 16.sp,
                        )
                      ],
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        children: [
          Material(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
              leading: SizedBox(
                height: 8.h,
                width: 25.w,
                child: ClipRRect(
                  child: Image.asset('assets/images/carousel_demo.jpg',fit: BoxFit.cover,),
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              title: Text("Gym",style:Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16.sp),),
            ),
          ),
        ],
      ),
    ));
  }
}
