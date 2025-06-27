import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Medication',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Iconsax.menu),
            onPressed: () {
              // Handle menu button press
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.notification),
              onPressed: () {
                // Handle notification button press
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
