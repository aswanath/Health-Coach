import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustom extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerCustom.rectangular(
      {Key? key,
      required this.width,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20)))})
      : super(key: key);

  const ShimmerCustom.circular(
      {Key? key,
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        period: const Duration(milliseconds: 1500),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
