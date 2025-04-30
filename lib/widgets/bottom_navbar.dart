import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 60,
      backgroundColor: const Color.fromARGB(255, 24, 20, 20),
      color: const Color.fromARGB(255, 115, 123, 134),
      animationDuration: const Duration(milliseconds: 300),
      onTap: onTap, // use your callback
      items: const [
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.fitness_center, color: Colors.white),
        Icon(Icons.person, color: Colors.white),
      ],
    );
  }
}
