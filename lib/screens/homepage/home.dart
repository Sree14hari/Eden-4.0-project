import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_medication/screens/homepage/homecomponent1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF5E96F3),
        leading: IconButton(
          icon: const Icon(Iconsax.menu, color: Colors.white),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, color: Colors.white),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: Homecomponent1(),
    );
  }
}
