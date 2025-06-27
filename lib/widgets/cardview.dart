// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Cardview extends StatelessWidget {
  final String iconpath;
  final String title;
  const Cardview({super.key, required this.iconpath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffA4C0F3).withOpacity(0.6),
          width: 1,
        ),
        color: Color(0xffA4C0F3).withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconpath, height: 50, width: 50),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: "Poppins regular",
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
