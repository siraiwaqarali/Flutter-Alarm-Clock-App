import 'package:clockapp/enums/menu_type.dart';
import 'package:clockapp/models/menu_info.dart';
import 'package:clockapp/res/app_colors.dart';
import 'package:clockapp/res/data.dart';
import 'package:clockapp/screens/alarm/alarm_screen.dart';
import 'package:clockapp/screens/clock/clock_screen.dart';
import 'package:clockapp/screens/home/components/home_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) =>
                    HomeMenuButton(currentMenuInfo: currentMenuInfo))
                .toList(),
          ),
          const VerticalDivider(color: AppColors.dividerColor, width: 1),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if (value.menuType == MenuType.clock) {
                  return const ClockScreen();
                } else if (value.menuType == MenuType.alarm) {
                  return const AlarmScreen();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 20),
                        children: <TextSpan>[
                          const TextSpan(text: 'Upcoming Tutorial\n'),
                          TextSpan(
                            text: value.title,
                            style: const TextStyle(fontSize: 48),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
