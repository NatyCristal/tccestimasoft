import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final Offset center;
  final double radius, containerHeight;
  final BuildContext context;

  Color color = Colors.white;
  double statusBarHeight = 0, screenWidth = 0;

  MyPainter(
      {required this.context,
      required this.containerHeight,
      required this.center,
      required this.radius}) {
    color = background;
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePainter = Paint();

    circlePainter.color = color;
    canvas.clipRect(
        Rect.fromLTWH(0, 0, screenWidth, containerHeight + statusBarHeight));
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
