import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_medication/screens/healthpage/healthpage.dart';
import 'package:smart_medication/screens/homepage/homecomponent1.dart';
import 'package:smart_medication/screens/notificationpage.dart';
import 'package:smart_medication/screens/shedule%20page/schedulepage.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuPressed() {
    _advancedDrawerController.showDrawer();
  }

  Future<void> detectPillWithRoboflow(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final File imageFile = File(image.path);

    final apiKey = "gju4pW2eYxLCzzlRxi8s";
    final model = "medicine";
    final version = 1;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse("https://detect.roboflow.com/$model/$version?api_key=$apiKey"),
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final json = jsonDecode(responseBody);
      final predictions = json['predictions'];

      if (predictions.isNotEmpty) {
        final pillName = predictions[0]['class'];
        final confidence = predictions[0]['confidence'];

        _showResultPopup(context, pillName, confidence);
      } else {
        _showResultPopup(context, "No pill detected", 0.0);
      }
    } else {
      _showResultPopup(context, "❌ Detection failed", 0.0);
    }
  }

  void _showResultPopup(
    BuildContext context,
    String pillName,
    double confidence,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "🧠 Pill Detection Result",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 10),
              Text(
                pillName,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              if (confidence > 0)
                Text(
                  "Confidence: ${(confidence * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: const Color(0XFF5E96F3),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      drawer: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0XFF5E96F3),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: ListTileTheme(
            iconColor: Colors.white,
            textColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Iconsax.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Home(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Right to left
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.activity),
                  title: const Text('Health Stats'),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HealthStatsPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Right to left
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.hospital),
                  title: const Text('Medical'),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Schedulepage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Right to left
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                ),
                const Spacer(),
                ListTile(
                  leading: const Icon(Iconsax.logout),
                  title: const Text('Logout'),
                  onTap: () {},
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF5E96F3),
          surfaceTintColor: const Color(0XFF5E96F3),
          leading: IconButton(
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.close : Iconsax.menu,
                    key: ValueKey<bool>(value.visible),
                    color: Colors.white,
                  ),
                );
              },
            ),
            onPressed: _handleMenuPressed,
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.notification, color: Colors.white),
              onPressed: () {
                // Handle notification button press
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const NotificationPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0); // Right to left
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          final tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                    transitionDuration: const Duration(milliseconds: 400),
                  ),
                );
              },
            ),
          ],
        ),
        body: const Homecomponent1(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFF5E96F3),
          child: const Icon(Iconsax.camera, color: Colors.white),
          onPressed: () => detectPillWithRoboflow(context),
        ),
      ),
    );
  }
}
