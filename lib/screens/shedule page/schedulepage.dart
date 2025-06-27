import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_medication/model/medical_schedulemodel.dart';
import 'package:smart_medication/widgets/hugecard.dart';

class Schedulepage extends StatefulWidget {
  const Schedulepage({super.key});

  @override
  State<Schedulepage> createState() => _SchedulepageState();
}

class _SchedulepageState extends State<Schedulepage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<List<MedicationModel>> _medicationsStream;

  @override
  void initState() {
    super.initState();
    _medicationsStream = _getMedicationsStream();
  }

  Stream<List<MedicationModel>> _getMedicationsStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User not logged in.");
    }

    return _firestore
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF5E96F3),
        title: const Text(
          "Medicine Schedule",
          style: TextStyle(
            fontFamily: "Poppins bold",
            fontSize: 21,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<List<MedicationModel>>(
        stream: _medicationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No medications found."));
          }

          final meds = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: meds
                  .map(
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
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
