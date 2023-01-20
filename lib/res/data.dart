import 'package:clockapp/enums/menu_type.dart';
import 'package:clockapp/models/alarm_info.dart';
import 'package:clockapp/models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/images/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/images/alarm_icon.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imageSource: 'assets/images/timer_icon.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imageSource: 'assets/images/stopwatch_icon.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
    alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
    title: 'Office',
    gradientColorIndex: 0,
  ),
  AlarmInfo(
    alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
    title: 'Sport',
    gradientColorIndex: 1,
  ),
];
