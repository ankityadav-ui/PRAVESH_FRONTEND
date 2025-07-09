import 'package:flutter/material.dart';
import 'package:pravesh_screen/FAQscreen.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/home_screen.dart';
import 'package:pravesh_screen/notifications.dart';
import 'package:pravesh_screen/profile.dart';

class Navbar extends StatefulWidget {
  final int initialIndex;

  const Navbar({super.key, this.initialIndex = 0});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Use the passed index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    Notifications(),
    ViewProfileScreen(),
    HelpCenterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors.box,
        unselectedItemColor: colors.white,
        selectedItemColor: const Color(0xff0ACF83),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: "Help"),
        ],
      ),
    );
  }
}
