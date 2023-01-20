import 'package:clockapp/res/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddAlarmButton extends StatelessWidget {
  final VoidCallback onAddAlarm;
  const AddAlarmButton({super.key, required this.onAddAlarm});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 2,
      color: AppColors.clockOutline,
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      dashPattern: const [5, 4],
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.clockBG,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: MaterialButton(
          onPressed: onAddAlarm,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            children: [
              Image.asset(
                'assets/images/add_alarm.png',
                scale: 1.5,
              ),
              const SizedBox(height: 8),
              const Text(
                'Add Alarm',
                style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
