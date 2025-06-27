import 'package:flutter/material.dart';
import 'package:smart_medication/widgets/hugecard.dart';

class Upcomingschedule extends StatelessWidget {
  const Upcomingschedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
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
            ],
          ),
        ),
      ),
    );
  }
}
