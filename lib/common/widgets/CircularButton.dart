import 'package:flutter/material.dart';
import 'package:tasbih/constants/colors.dart';

class CircularButton extends StatelessWidget {
  final double height;
  final double width;
  final double iconSize;
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final Function onPressed;

  const CircularButton({
    super.key,
    required this.height,
    required this.width,
    required this.iconSize,
    required this.icon,
    this.iconColor = Colors.white, // Default icon color
    this.circleColor = MyColors.lightPrimaryColor,
    required this.onPressed, // Default circle color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
        child: Center(
          child: Icon(
            icon,
            size:
                iconSize, // You can also pass size as an additional parameter if needed
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
