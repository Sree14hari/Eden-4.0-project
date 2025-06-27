// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:smart_medication/screens/homepage/upcomingschedule.dart';
import 'package:smart_medication/widgets/cardview.dart';

class Homecomponent1 extends StatefulWidget {
  const Homecomponent1({super.key});

  @override
  State<Homecomponent1> createState() => _Homecomponent1State();
}

class _Homecomponent1State extends State<Homecomponent1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0XFF5E96F3)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 5),
            child: Row(
              children: [
                const Text(
                  "Hey, ",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Poppins Bold",
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Sreehari",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Poppins Bold",
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "!",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Poppins Bold",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Cardview(
                    iconpath: "assets/images/pils.png",
                    title: "Schedule",
                  ),
                  Cardview(
                    iconpath: "assets/images/emer.png",
                    title: "Emergency",
                  ),
                  Cardview(
                    iconpath: "assets/images/stats.png",
                    title: "Health",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Upcomingschedule(),
        ],
      ),
    );
  }
}
