import 'package:flutter/material.dart';

class CustomNextButton extends StatelessWidget {
  final double scale;
  final Color containerColor;
  final Color iconColor;
  final VoidCallback onPressed;
  const CustomNextButton({Key? key,required this.scale,required this.iconColor,required this.containerColor,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: scale,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(color: iconColor),
            borderRadius: BorderRadius.circular(20)),
        duration: const Duration(milliseconds: 300),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_forward_rounded,
            color: iconColor,
          ),
          splashRadius: .01,
        ),
      ),
    );
  }
}
