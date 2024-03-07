import 'package:corpo/models/themes/theme.dart';
import 'package:flutter/material.dart';


class LineAnimation extends StatefulWidget {
  final Offset startPoint;
  final Offset midPoint;
  final Offset endPoint;
  final Color color;
  final int duration1;
  final int duration2;

  const LineAnimation({
    Key? key,
    required this.startPoint,
    required this.midPoint,
    required this.endPoint,
    required this.color,
    required this.duration1,
    required this.duration2,
  }) : super(key: key);

  @override
  _LineAnimationState createState() => _LineAnimationState();
}

class _LineAnimationState extends State<LineAnimation> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: Duration(seconds: widget.duration1),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0, end: 1).animate(_controller1);

    _controller2 = AnimationController(
      duration: Duration(seconds: widget.duration2),
      vsync: this,
    );

    _animation2 = Tween<double>(begin: 0, end: 1).animate(_controller2);

    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.forward();
      }
    });

    _controller1.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AnimatedLinePainter(
        animation1: _animation1,
        animation2: _animation2,
        startPoint: widget.startPoint,
        midPoint: widget.midPoint,
        endPoint: widget.endPoint,
        color: widget.color,
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

class AnimatedLinePainter extends CustomPainter {
  final Animation<double> animation1;
  final Animation<double> animation2;
  final Offset startPoint;
  final Offset endPoint;
  final Offset midPoint;
  final Color color;
 
  AnimatedLinePainter({required this.animation1, required this.animation2, required this.startPoint,  required this.midPoint,
    required this.endPoint, required this.color}) : super(repaint: animation1);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.65)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw line from point 1 to point 2
    canvas.drawLine(
      startPoint,
      Offset.lerp(startPoint, midPoint, animation1.value)!,
      paint,
    );

    // Draw line from point 2 to point 3 after animation1 completes
    if (animation2.value > 0) {
      canvas.drawLine(
        midPoint,
        Offset.lerp(midPoint, endPoint, animation2.value)!,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}