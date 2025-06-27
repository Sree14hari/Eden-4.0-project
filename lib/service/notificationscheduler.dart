import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_medication/main.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> scheduleMedicationNotification({
  required String medName,
  required String dosage,
  required TimeOfDay time,
}) async {
  final now = DateTime.now();
  final scheduledDate = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );

  final tzDateTime = tz.TZDateTime.from(scheduledDate, tz.local);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    medName.hashCode, // Unique ID
    'Medication Reminder',
    '$medName ($dosage) - Time to take it!',
    tzDateTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'medication_channel',
        'Medication Alerts',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
  );
}
