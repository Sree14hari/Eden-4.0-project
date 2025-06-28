import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_medication/model/medical_schedulemodel.dart';
import 'package:smart_medication/service/notificationscheduler.dart';
import 'package:smart_medication/service/talkback.dart';
import 'package:smart_medication/widgets/hugecard.dart';

class Upcomingschedule extends StatefulWidget {
  const Upcomingschedule({super.key});

  @override
  State<Upcomingschedule> createState() => _UpcomingscheduleState();
}

class _UpcomingscheduleState extends State<Upcomingschedule> {
  late Stream<List<MedicationModel>> _medicationsStream;

  @override
  void initState() {
    super.initState();
    _medicationsStream = _getMedicationsStream();
  }

  Stream<List<MedicationModel>> _getMedicationsStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception("User not logged in.");

    return FirebaseFirestore.instance
        .collection('medications')
        .where('user_id', isEqualTo: userId)
        .orderBy('time')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return MedicationModel(
              id: doc.id,
              name: data['name'] ?? '',
              dosage: data['dosage'] ?? '',
              time: data['time'] ?? '',
              date: data['date'] ?? '',
              status: data['status'] ?? 'pending',
              frequency: data['frequency'] ?? 'daily',
            );
          }).toList(),
        );
  }

  void _scheduleAllNotifications(List<MedicationModel> meds) {
    for (final med in meds) {
      try {
        final timeParts = med.time.split(':');
        final hour = int.tryParse(timeParts[0]) ?? 0;
        final minute = int.tryParse(timeParts[1]) ?? 0;

        scheduleMedicationNotification(
          medName: med.name,
          dosage: med.dosage,
          time: TimeOfDay(hour: hour, minute: minute),
        );
      } catch (e) {
        debugPrint('❌ Notification error for ${med.name}: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: StreamBuilder<List<MedicationModel>>(
          stream: _medicationsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No upcoming medications found."),
              );
            }

            final meds = snapshot.data!;

            // ✅ Schedule only once after fetching data
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scheduleAllNotifications(meds);
            });

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 0, 0),
                    child: Text(
                      "Upcoming Schedule",
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: "Poppins bold",
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...meds.map(
                    (med) => Hugecard(
                      mname: "${med.name} ${med.dosage}",
                      date: med.date,
                      time: med.time,
                      dosage:
                          "Status: ${med.status}, Frequency: ${med.frequency}",
                      status: med.status,
                      onDone: () {
                        speak("Medicine ${med.name} has Taken.");
                        FirebaseFirestore.instance
                            .collection('medications')
                            .doc(med.id)
                            .update({'status': 'taken'});

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Marked as taken ✅")),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
