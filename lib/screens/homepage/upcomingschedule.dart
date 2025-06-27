import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_medication/model/medical_schedulemodel.dart';
import 'package:smart_medication/widgets/hugecard.dart';

class Upcomingschedule extends StatelessWidget {
  const Upcomingschedule({super.key});

  Stream<List<MedicationModel>> _getMedicationsStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User not logged in.");
    }

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
          stream: _getMedicationsStream(),
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
