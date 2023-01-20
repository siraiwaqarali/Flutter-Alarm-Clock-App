import 'dart:async';
import 'dart:math' as math;
import 'package:clockapp/res/app_colors.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;
  const ClockView({super.key, required this.size});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -math.pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime = DateTime.now();
  // 60 sec - 360, 1 sec - 6 degree
  // 12 hours  - 360, 1 hour - 30 degrees, 1 min - 0.5 degrees

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final Offset center = Offset(centerX, centerY);
    final double radius = math.min(centerX, centerY);

    final Paint fillBrush = Paint()..color = AppColors.clockBG;
    final Paint outlineBrush = Paint()
      ..color = AppColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;
    final Paint centerDotBrush = Paint()..color = AppColors.clockOutline;

    final Paint secondHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;
    final Paint minuteHandBrush = Paint()
      ..shader = const RadialGradient(
              colors: [AppColors.minHandStatColor, AppColors.minHandEndColor])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;
    final Paint hourHandBrush = Paint()
      ..shader = const RadialGradient(
              colors: [AppColors.hourHandStatColor, AppColors.hourHandEndColor])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;

    final Paint dashBrush = Paint()
      ..color = AppColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    var hourHandX = centerX +
        radius *
            0.4 *
            math.cos(
                (dateTime.hour * 30 + dateTime.minute * 0.5) * math.pi / 180);
    var hourHandY = centerY +
        radius *
            0.4 *
            math.sin(
                (dateTime.hour * 30 + dateTime.minute * 0.5) * math.pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX =
        centerX + radius * 0.6 * math.cos(dateTime.minute * 6 * math.pi / 180);
    var minHandY =
        centerY + radius * 0.6 * math.sin(dateTime.minute * 6 * math.pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minuteHandBrush);

    var secHandX =
        centerX + radius * 0.6 * math.cos(dateTime.second * 6 * math.pi / 180);
    var secHandY =
        centerY + radius * 0.6 * math.sin(dateTime.second * 6 * math.pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondHandBrush);

    canvas.drawCircle(center, radius * 0.12, centerDotBrush);

    final double outerRadius = radius;
    final double innerRadius = radius * 0.9;
    for (int i = 0; i < 360; i += 12) {
      final double x1 = centerX + outerRadius * math.cos(i * math.pi / 180);
      final double y1 = centerY + outerRadius * math.sin(i * math.pi / 180);

      final double x2 = centerX + innerRadius * math.cos(i * math.pi / 180);
      final double y2 = centerY + innerRadius * math.sin(i * math.pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
