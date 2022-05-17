import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';

import '../theme/theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Widget? child;

  const CustomElevatedButton(
      {Key? key, required this.voidCallback,this.child, required this.text, this.foregroundColor, this.backgroundColor,this.padding,this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(BorderSide(color: borderColor??Colors.transparent)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
        padding: MaterialStateProperty.all(padding),
        backgroundColor: MaterialStateProperty.all(backgroundColor??commonGreen)
      ),
        onPressed: voidCallback,
        child: child??Text(
          text,
          style: themeData.textTheme.headlineMedium!.copyWith(color: foregroundColor),
        ));
  }
}
