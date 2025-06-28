import 'package:flutter/material.dart';
import 'package:smart_medication/service/talkback.dart';
import 'package:url_launcher/url_launcher.dart';

class SosTapScreen extends StatefulWidget {
  const SosTapScreen({super.key});

  @override
  State<SosTapScreen> createState() => _SosTapScreenState();
}

class _SosTapScreenState extends State<SosTapScreen> {
  Color appBarColor = Colors.blue;
  bool _isCalling = false;

  Future<void> _onSosTap() async {
    if (_isCalling) return;

    setState(() {
      appBarColor = Colors.red;
      _isCalling = true;
    });

    try {
      const phoneNumber = '+919946582510'; // Replace with emergency number
      final Uri callUri = Uri.parse(
        'tel:$phoneNumber',
      ); // Better parsing method

      if (await canLaunchUrl(callUri)) {
        speak("Emergency alert has been sent to admin");
        await launchUrl(callUri, mode: LaunchMode.externalApplication);
      } else {
        speak("Emergency alert has been sent to admin");
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      setState(() {
        appBarColor = Colors.blue;
        _isCalling = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'SOS Tap',
          style: TextStyle(
            fontFamily: "Poppins Bold",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _onSosTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBarColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.asset(
              'assets/images/sos.png',
              width: 200,
              height: 200,
              color: appBarColor,
            ),
          ),
        ),
      ),
    );
  }
}
