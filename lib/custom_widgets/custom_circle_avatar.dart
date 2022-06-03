import 'package:flutter/material.dart';
import 'package:health_coach/constants/constants.dart';

class HalfCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = commonGreen;

    canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2),
          height: size.height * 1.1,
          width: size.width * 1.1,
        ),
        4.5,
        4.5,
        false,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}