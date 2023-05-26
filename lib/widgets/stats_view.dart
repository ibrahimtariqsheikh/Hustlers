import 'package:flutter/material.dart';

class StatsView extends StatelessWidget {
  final String text;
  final double value;
  final Color color;
  final int percentage;

  const StatsView({
    Key? key,
    required this.text,
    required this.value,
    required this.color,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int intValue = value.toInt();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          width: 50,
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Theme.of(context).colorScheme.onTertiary,
              )),
          child: Stack(
            children: [
              CustomPaint(
                painter: _FillPainter(percentage, color),
                child: Container(),
              ),
              Positioned(
                top: (160 -
                        (100 * (percentage > 100 ? 100 : percentage) / 100)) -
                    50,
                right: 0,
                left: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    intValue.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
      ],
    );
  }
}

class _FillPainter extends CustomPainter {
  final int percentage;
  final Color color;

  _FillPainter(this.percentage, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double minHeight = 55;
    double fillHeight = minHeight +
        (size.height - minHeight) * (percentage > 100 ? 100 : percentage) / 100;
    Paint fillPaint = Paint()..color = color;

    RRect inner = RRect.fromLTRBR(
      0,
      size.height - fillHeight,
      size.width,
      size.height,
      const Radius.circular(50),
    );

    canvas.drawRRect(inner, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
