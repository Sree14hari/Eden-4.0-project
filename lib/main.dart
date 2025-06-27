import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import
import 'package:smart_medication/app.dart';

void main() {
  // Make the status bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness:
          Brightness.dark, // Use dark icons if your background is light
    ),
  );
  runApp(const MyApp());
}
