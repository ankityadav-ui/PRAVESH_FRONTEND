import 'package:flutter/material.dart';
import 'package:pravesh_screen/guard/visitor_photo.dart';

void main() {
  runApp(const MyApp());
}

/// Main Application Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guard Dashboard',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1F2A),
        fontFamily: 'Inter',
      ),
      home: const GuardDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The Guard Dashboard Screen
class GuardDashboardScreen extends StatelessWidget {
  const GuardDashboardScreen({super.key});
  
  // Gets the correct greeting based on the current time of day.
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
            const SizedBox(height: 30),
            _buildBottomActions(cardColor),
          ],
        ),
      ),
    );
  }

  /// Builds the top header with greeting and weather.
  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: Color(0xFFE0E0E0),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello Guard',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Text(
              _greeting,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Row(
              children: [
                Icon(Icons.wb_sunny_rounded, color: Color(0xFFFFC107), size: 20),
                SizedBox(width: 6),
                Text(
                  '25°',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              'Borkhedi, India',
              style: TextStyle(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the row of two statistics cards.
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

  /// Builds the title for a section.
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }

  /// Builds the large, green "Register New Visitor" button.
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

  /// Builds the list item for a single recent request.
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

  /// Builds the two action buttons at the bottom.
  Widget _buildBottomActions(Color cardColor) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            color: cardColor,
            icon: Icons.call_outlined,
            label: 'Emergency',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ActionButton(
            color: cardColor,
            icon: Icons.notifications_outlined,
            label: 'Alerts',
          ),
        ),
      ],
    );
  }
}

/// A private, reusable widget for the statistics cards.
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

/// A private, reusable widget for the bottom action buttons.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 22),
      label: Text(label),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white.withOpacity(0.85),
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
