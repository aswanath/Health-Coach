import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final double? transform;
  final bool isTrailing;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.transform,
    this.onTap,
    this.isTrailing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Transform.rotate(
          angle: transform ?? 0,
          child: Iconify(
            leadingIcon,
            size: 20.sp,
          ),
        ),
        title: Text(
          title,
          style:
              Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14.sp),
        ),
        trailing: isTrailing
            ? Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.sp,
                color: commonBlack,
              )
            : null,
      ),
    );
  }
}
