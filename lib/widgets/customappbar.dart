import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppbarC extends StatelessWidget implements PreferredSizeWidget {
  const AppbarC({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Iconsax.menu)),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.notification),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 5),
              child: Row(
                children: [
                  const Text(
                    "Hey, ",
                    style: TextStyle(fontSize: 24, fontFamily: "Poppins Bold"),
                  ),
                  const Text(
                    "Sreehari",
                    style: TextStyle(fontSize: 24, fontFamily: "Poppins Bold"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200); // Adjust the height as needed
}
