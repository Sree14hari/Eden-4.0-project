import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // POST - Add new medication
  Future<void> addMedication({
    required String name,
    required String dosage,
    required String time,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception('User not logged in');

    await _firestore.collection('medications').add({
      'user_id': userId,
      'name': name,
      'dosage': dosage,
      'time': time,
      'date': DateTime.now().toIso8601String(),
      'status': 'pending',
      'frequency': 'daily',
    });
  }

  // GET - Fetch all medications for current user
  Stream<List<Map<String, dynamic>>> getMedications() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception('User not logged in');

    return _firestore
        .collection('medications')
        .where('user_id', isEqualTo: userId)
        .orderBy('time')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
