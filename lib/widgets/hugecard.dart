// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Hugecard extends StatelessWidget {
  final String mname;
  final String date;
  final String time;
  final String dosage;
  final String status; // NEW
  final VoidCallback? onDone; // NEW

  const Hugecard({
    super.key,
    required this.mname,
    required this.date,
    required this.time,
    required this.dosage,
    required this.status,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTaken = status.toLowerCase() == 'taken';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffA4C0F3).withOpacity(0.6),
            width: 1,
          ),
          color: isTaken
              ? const Color.fromARGB(255, 226, 251, 233)
              : const Color(0xffECF2FE).withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top row: date, time, done button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Iconsax.calendar,
                    size: 20,
                    color: Color(0xff919BA7),
                  ),
                ),
                Text(
                  "$date, ",
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "Poppins Regular",
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "Poppins Regular",
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: isTaken ? null : onDone,
                      style: TextButton.styleFrom(
                        backgroundColor: isTaken
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: isTaken
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 83, 190, 86),
                          ),
                        ),
                      ),
                      child: Text(
                        isTaken ? "Taken" : "Done",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.withOpacity(0.5),
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Pill image
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xffA4C0F3).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/pils.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Medication details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mname,
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: "Poppins Regular",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.clock,
                            size: 13,
                            color: Color(0xff919BA7),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            dosage,
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: "Poppins Regular",
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
