import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For time formatting
import 'package:pravesh_screen/guard/visitor_photo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guard Dashboard',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 52, 59, 72),
        fontFamily: 'Inter',
      ),
      home: const GuardDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GuardDashboardScreen extends StatelessWidget {
  const GuardDashboardScreen({super.key});

  String get _currentTime {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF273348);
    const accentGreen = Color(0xFF34D17B);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatsRow(cardColor),
            const SizedBox(height: 30),
            _buildSectionTitle('Visitor Management'),
            const SizedBox(height: 16),
            _buildRegisterButton(context, accentGreen),
            const SizedBox(height: 30),
            _buildSectionTitle('Recent Requests'),
            const SizedBox(height: 16),
            _buildRecentRequestItem(cardColor, accentGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _greeting,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _currentTime,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 2),
            const Text(
              'Nagpur, Maharashtra',
              style: TextStyle(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow(Color cardColor) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            color: cardColor,
            icon: Icons.people_alt_outlined,
            iconColor: Colors.blue.shade300,
            title: "Today's Visitors",
            value: '12',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            color: cardColor,
            icon: Icons.shield_outlined,
            iconColor: Colors.green.shade400,
            title: 'Active Requests',
            value: '0',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }

  Widget _buildRegisterButton(BuildContext context, Color accentGreen) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.person_add_alt_1_outlined, size: 22),
      label: const Text('Register New Visitor'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CaptureVisitorPhotoScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: accentGreen,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
      ),
    );
  }

  Widget _buildRecentRequestItem(Color cardColor, Color accentGreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('user', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              SizedBox(height: 4),
              Text('To: Prof. Brown', style: TextStyle(fontSize: 14, color: Colors.white70)),
            ],
          ),
          Chip(
            label: const Text('approved'),
            labelStyle: TextStyle(color: accentGreen, fontWeight: FontWeight.w600, fontSize: 12),
            backgroundColor: accentGreen.withOpacity(0.15),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            side: BorderSide.none,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  final Color color;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.15),
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
