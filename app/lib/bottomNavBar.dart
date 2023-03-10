import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'main1.dart';
import 'main2.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int curr = 0;
  final screens = [
    DemoApp(),
    DemoApp2(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[curr],
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        color: Colors.black,
        activeColor: Colors.black,
        tabs: const [
        GButton(icon: Icons.home, text: "HOME",),
        GButton(icon: Icons.search, text: "Search",),
      ],
      onTabChange: (index) {
        setState(() {
          curr = index;
        });
      },
      ),
    );
  }
}
