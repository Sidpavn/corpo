
import 'package:flutter/material.dart';

import '../../../models/themes/theme.dart';

class AnimatedLineBetweenPoints extends StatefulWidget {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;
  final int duration;

  const AnimatedLineBetweenPoints({
    Key? key,
    required this.startPoint,
    required this.endPoint,
    required this.color,
    required this.duration,
  }) : super(key: key);

  @override
  _AnimatedLineBetweenPointsState createState() => _AnimatedLineBetweenPointsState();
}

class _AnimatedLineBetweenPointsState extends State<AnimatedLineBetweenPoints> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final linePoint = Offset(
          widget.startPoint.dx + (_animation.value * (widget.endPoint.dx - widget.startPoint.dx)),
          widget.startPoint.dy + (_animation.value * (widget.endPoint.dy - widget.startPoint.dy)),
        );

        return CustomPaint(
          painter: AnimatedLinePainter(widget.startPoint, linePoint, widget.color),
        );
      },
    );
  }
}

class AnimatedLinePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;

  AnimatedLinePainter(this.startPoint, this.endPoint, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.65)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
