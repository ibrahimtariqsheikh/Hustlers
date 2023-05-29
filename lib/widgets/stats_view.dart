import 'package:flutter/material.dart';

class StatsView extends StatefulWidget {
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
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late _FillPainter _fillPainter;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 1), // Set the desired animation duration
    );
    _fillPainter = _FillPainter(_controller, widget.color, widget.percentage);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int intValue = widget.value.toInt();
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
            ),
          ),
          child: Stack(
            children: [
              CustomPaint(
                painter: _fillPainter,
                child: Container(),
              ),
              Positioned(
                bottom: 5,
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
          widget.text,
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
      ],
    );
  }
}

class _FillPainter extends CustomPainter with ChangeNotifier {
  final AnimationController controller;
  final Animation<double> animation;
  final Color color;
  final int percentage;

  _FillPainter(this.controller, this.color, this.percentage)
      : animation = Tween<double>(
                begin: 0.0,
                end: (percentage < 32)
                    ? 0.32
                    : (percentage > 100)
                        ? 1.0
                        : percentage.toDouble() / 100)
            .animate(controller) {
    controller.addListener(() {
      notifyListeners();
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    double fillHeight = size.height * animation.value;
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
