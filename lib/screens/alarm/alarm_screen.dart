import 'package:clockapp/helpers/alarm_helper.dart';
import 'package:clockapp/models/alarm_info.dart';
import 'package:clockapp/res/app_colors.dart';
import 'package:clockapp/res/data.dart';
import 'package:clockapp/screens/alarm/components/add_alarm_button.dart';
import 'package:clockapp/screens/alarm/components/alarm_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:clockapp/main.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime? _alarmTime;
  late String _alarmTimeString;
  bool _isRepeatSelected = false;
  final AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  @override
  void initState() {
    super.initState();
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      loadAlarms();
    });
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              color: AppColors.primaryTextColor,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'Loading..',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                _currentAlarms = snapshot.data;
                return ListView(
                  children: snapshot.data!
                      .map<Widget>(
                    (alarm) => AlarmItem(
                      alarmInfo: alarm,
                      onDelete: () {
                        deleteAlarm(alarm.id);
                      },
                    ),
                  )
                      .followedBy([
                    if (alarms.length < 5)
                      AddAlarmButton(
                        onAddAlarm: () {
                          _alarmTimeString =
                              DateFormat('HH:mm').format(DateTime.now());
                          showModalBottomSheet(
                            useRootNavigator: true,
                            context: context,
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return Container(
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            var selectedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if (selectedTime != null) {
                                              final now = DateTime.now();
                                              var selectedDateTime = DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                selectedTime.hour,
                                                selectedTime.minute,
                                              );
                                              _alarmTime = selectedDateTime;
                                              setModalState(() {
                                                _alarmTimeString =
                                                    DateFormat('HH:mm').format(
                                                        selectedDateTime);
                                              });
                                            }
                                          },
                                          child: Text(
                                            _alarmTimeString,
                                            style:
                                                const TextStyle(fontSize: 32),
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text('Repeat'),
                                          trailing: Switch(
                                            onChanged: (value) {
                                              setModalState(() {
                                                _isRepeatSelected = value;
                                              });
                                            },
                                            value: _isRepeatSelected,
                                          ),
                                        ),
                                        const ListTile(
                                          title: Text('Sound'),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                        ),
                                        const ListTile(
                                          title: Text('Title'),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                        ),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            onSaveAlarm(_isRepeatSelected);
                                          },
                                          icon: const Icon(Icons.alarm),
                                          label: const Text('Save'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      )
                    else
                      const Center(
                        child: Text(
                          'Only 5 alarms allowed!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ]).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm(
    DateTime scheduledNotificationDateTime,
    AlarmInfo alarmInfo, {
    required bool isRepeating,
  }) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('android_a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      sound: 'ios_a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Office',
      alarmInfo.title,
      tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents:
          isRepeating ? DateTimeComponents.dayOfWeekAndTime : null,
    );
  }

  void onSaveAlarm(bool isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime;
    } else {
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      scheduleAlarm(scheduleAlarmDateTime, alarmInfo, isRepeating: isRepeating);
    }
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
