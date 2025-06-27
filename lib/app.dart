import 'package:flutter/material.dart';
import 'package:smart_medication/screens/homepage/home.dart';
import 'package:smart_medication/screens/shedule%20page/schedulepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Medication',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
