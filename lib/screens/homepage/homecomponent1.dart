// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:smart_medication/screens/healthpage/healthpage.dart';
import 'package:smart_medication/screens/homepage/upcomingschedule.dart';
import 'package:smart_medication/screens/shedule%20page/schedulepage.dart';
import 'package:smart_medication/screens/sos/sospage.dart';
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                    child: Cardview(
                      iconpath: "assets/images/pils.png",
                      title: "Schedule",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Sospage(),
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
                    child: Cardview(
                      iconpath: "assets/images/emer.png",
                      title: "Emergency",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const HealthStatsPageMock(),
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
                    child: Cardview(
                      iconpath: "assets/images/stats.png",
                      title: "Health",
                    ),
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
