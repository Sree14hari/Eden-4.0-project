import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
    medName.hashCode,
    'Medication Reminder',
    '$medName ($dosage) - Time to take it!',
    tzDateTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'med_channel',
        'Medication Alerts',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  // ✅ Save to Firestore (for display in notification page)
  await FirebaseFirestore.instance.collection('notifications').add({
    'med_name': medName,
    'dosage': dosage,
    'scheduled_time': scheduledDate.toIso8601String(),
    'timestamp': FieldValue.serverTimestamp(),
    'status': 'scheduled', // or 'shown' if already delivered
  });
}
