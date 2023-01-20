import 'dart:async';

import 'package:clockapp/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({super.key});

  @override
  State<DigitalClockWidget> createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int perviousMinute =
          DateTime.now().add(const Duration(seconds: -1)).minute;
      int currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute) {
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: const TextStyle(
        fontFamily: 'avenir',
        color: AppColors.primaryTextColor,
        fontSize: 64,
      ),
    );
  }
}
