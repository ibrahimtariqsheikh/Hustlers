import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final double percentage;
  final double width;
  final double height;
  final Color color;
  final double paintWidth;
  final String? centerText;

  const CircularProgress({
    Key? key,
    required this.percentage,
    required this.color,
    required this.width,
    required this.height,
    required this.paintWidth,
    this.centerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        foregroundPainter: CircularProgressPainter(
          lineColor: Colors.grey,
          completeColor: color,
          completePercent: percentage,
          width: paintWidth,
        ),
        child: centerText != null
            ? Center(
                child: Text(
                  centerText!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : null,
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  CircularProgressPainter({
    required this.lineColor,
    required this.completeColor,
    required this.completePercent,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (completePercent / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      complete,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
