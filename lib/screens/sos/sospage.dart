import 'package:flutter/material.dart';

class Sospage extends StatefulWidget {
  const Sospage({super.key});

  @override
  State<Sospage> createState() => _SospageState();
}

class _SospageState extends State<Sospage> {
  Color appBarColor = const Color(0XFF5E96F3); // Initial color

  void _onSosTap() {
    setState(() {
      appBarColor = Colors.red; // Change to red on tap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "SOS",
          style: TextStyle(
            fontFamily: "Poppins bold",
            fontSize: 21,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _onSosTap,
          child: Image.asset("assets/images/sos.png", height: 200, width: 200),
        ),
      ),
    );
  }
}
