import 'dart:math';

import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatefulWidget {
  final double radius;
  final Color color;
  final double strokeWidth;

  CustomCircularIndicator({
    this.radius = 20.0,
    this.color = Colors.blue,
    this.strokeWidth = 4.0,
  });

  @override
  _CustomCircularIndicatorState createState() => _CustomCircularIndicatorState();
}

class _CustomCircularIndicatorState extends State<CustomCircularIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();

    _animation = Tween(begin: 0.0, end: 2 * pi).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: CircularIndicatorPainter(
                progress: _animation.value,
                color: widget.color,
                strokeWidth: widget.strokeWidth,
              ),
              child: SizedBox(
                width: widget.radius * 3,
                height: widget.radius * 3,
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        const Center(child: Text("Vui lòng đợi!"))
      ],
    );
  }
}

class CircularIndicatorPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CircularIndicatorPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - strokeWidth / 2;
    const startAngle = -pi / 2;
    final sweepAngle = progress;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
