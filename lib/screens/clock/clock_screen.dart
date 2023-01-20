import 'package:clockapp/res/app_colors.dart';
import 'package:clockapp/screens/clock/components/clock_view.dart';
import 'package:clockapp/screens/clock/components/digital_clock_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, d MMM').format(now);
    String timezoneString = now.timeZoneOffset.toString().split('.').first;
    String offsetSign = '';
    if (!timezoneString.startsWith('-')) {
      offsetSign = '+';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Clock',
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: AppColors.primaryTextColor,
                fontSize: 24,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const DigitalClockWidget(),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w300,
                    color: AppColors.primaryTextColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.center,
              child: ClockView(
                size: MediaQuery.of(context).size.height / 4,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Timezone',
                  style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryTextColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: AppColors.primaryTextColor,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'UTC$offsetSign$timezoneString',
                      style: const TextStyle(
                        fontFamily: 'avenir',
                        color: AppColors.primaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
