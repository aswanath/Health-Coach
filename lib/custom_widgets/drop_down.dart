import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_coach/constants/constants.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown extends StatelessWidget {
  final String? Function(String?)? onChanged;
  final String? value;

  CustomDropDown({Key? key, required this.onChanged, this.value})
      : super(key: key);
  final items = ["Post Graduation", "Diploma", "Degree"];

  @override
  Widget build(BuildContext context) {
    return FadeInDownBig(
      duration: const Duration(milliseconds: 500),
      from: 100,
      delay: const Duration(milliseconds: 100),
      child: SizedBox(
        height: 13.5.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Highest Qualification',
              style: GoogleFonts.nunito(
                  color: commonBlack,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: .5.h,
            ),
            ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: onChanged,
                borderRadius: BorderRadius.circular(11),
                iconSize: 0,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: commonGreen,
                      size: 28.sp,
                    ),
                    hintStyle: GoogleFonts.nunito(
                        color: Colors.grey[400], fontSize: 10.5.sp),
                    counterText: '',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: const Iconify(
                        ageIcon,
                        color: commonGreen,
                      ),
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
                    hintText: 'Post Graduation'),
                value: value,
                focusColor: commonGreen.withOpacity(.5),
                hint: Text(
                  "Post Graduate",
                  style: GoogleFonts.nunito(
                      color: Colors.grey[400], fontSize: 10.5.sp),
                ),
                isExpanded: true,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: GoogleFonts.nunito(),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
