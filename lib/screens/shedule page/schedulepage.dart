import 'package:flutter/material.dart';
import 'package:smart_medication/widgets/hugecard.dart';

class Schedulepage extends StatelessWidget {
  const Schedulepage({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 5; i++) ...[
              Hugecard(
                mname: "Paracetamol 500mg",
                date: "${i + 1}/08/2023",
                time: "${i + 6}:00 PM",
                dosage: "Dosage: 2 times a day",
              ),
            ],
          ],
        ),
      ),
    );
  }
}
