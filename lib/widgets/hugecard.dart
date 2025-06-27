// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Hugecard extends StatelessWidget {
  final String mname;
  final String date;
  final String time;
  final String dosage;
  const Hugecard({
    super.key,
    required this.mname,
    required this.date,
    required this.time,
    required this.dosage,
  });

  @override
  Widget build(BuildContext context) {
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
          color: Color(0xffECF2FE).withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Iconsax.calendar,
                    size: 20,
                    color: Color(0xff919BA7),
                  ),
                ),
                Text(
                  "$date, ",
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Poppins Regular",
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Poppins Regular",
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(color: Colors.green),
                        ),
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(
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
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffA4C0F3).withOpacity(0.6),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mname,
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Poppins Regular",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.clock,
                            size: 13,
                            color: Color(0xff919BA7),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            dosage,
                            style: TextStyle(
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
