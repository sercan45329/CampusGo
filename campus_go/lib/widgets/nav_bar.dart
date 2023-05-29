import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.grey.shade800,
        gap: 10,
        padding: EdgeInsets.all(context.screenHeight * 0.02),
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.person, text: 'Profile'),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
          )
        ]);
  }
}
