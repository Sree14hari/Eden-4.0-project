import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:smart_medication/screens/healthpage/healthpage.dart';
import 'package:smart_medication/screens/homepage/homecomponent1.dart';
import 'package:smart_medication/screens/shedule%20page/schedulepage.dart';

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
              },
            ),
          ],
        ),
        body: const Homecomponent1(),
      ),
    );
  }
}
