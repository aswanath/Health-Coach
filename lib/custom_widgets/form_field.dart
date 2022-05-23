import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/theme/theme.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final String head;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final Function(String)? onChanged;
  final int delay;
  final int? maxLines;
  final double? height;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextEditingController? textEditingController;

  const CustomTextField({
    this.textEditingController,
    this.maxLength,
    this.textInputAction,
    this.height,
    this.maxLines,
    required this.validator,
    required this.delay,
    this.obscureText,
    this.onChanged,
    this.inputFormatters,
    this.textInputType,
    required this.head,
    required this.hintText,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDownBig(
      duration: const Duration(milliseconds: 500),
      from: 100,
      delay: Duration(milliseconds: delay),
      child: SizedBox(
        height: height??13.5.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              head,
              style: GoogleFonts.nunito(
                  color: commonBlack,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: .5.h,
            ),
            TextFormField(
              controller: textEditingController,
              textCapitalization: TextCapitalization.words,
              maxLength: maxLength??165,
              maxLines: maxLines??1,
              onChanged: onChanged,
              textInputAction: textInputAction??TextInputAction.next,
              obscureText: obscureText ?? false,
              inputFormatters: inputFormatters,
              keyboardType: textInputType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              cursorColor: commonGreen,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                hintStyle: GoogleFonts.nunito(color:Colors.grey[400],fontSize: 10.5.sp),
                counterText: '',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: icon,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 32,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: commonGreen,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: commonGreen,
                      width: 2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: commonGreen,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  hintText: hintText),
            ),
          ],
        ),
      ),
    );
  }
}