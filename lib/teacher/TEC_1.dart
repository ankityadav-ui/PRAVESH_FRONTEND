import 'package:flutter/material.dart';
import 'package:pravesh_screen/teacher/TEC_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Dashboard',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1F2A),
        fontFamily: 'Inter',
      ),
      home: const TeacherDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

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
            _buildMyGateSection(context, accentGreen), // ✅ context passed
            const SizedBox(height: 16),
            _buildBottomActions(cardColor),
          ],
        ),
      ),
    );
  }

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
              'Hello Dr. Smith',
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
                  '28°',
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

  Widget _buildStatsRow(Color cardColor) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            color: cardColor,
            icon: Icons.people_alt_outlined,
            label: "Today's Classes",
            value: '4',
            iconColor: Colors.blue.shade300,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            color: cardColor,
            icon: Icons.shield_outlined,
            label: 'Pending Visitors',
            value: '3',
            iconColor: Colors.orange.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildMyGateSection(BuildContext context, Color accentGreen) { // ✅ context added
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'My Gate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            Chip(
              label: const Text('3 Pending'),
              labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              backgroundColor: accentGreen,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.shield_outlined, size: 22),
          label: const Text('Manage Visitors'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VisitorRequestsScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: accentGreen,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
          ),
        )
      ],
    );
  }

  Widget _buildBottomActions(Color cardColor) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            color: cardColor,
            icon: Icons.calendar_today_outlined,
            label: 'My Schedule',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ActionButton(
            color: cardColor,
            icon: Icons.groups_outlined,
            label: 'Class List',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.color,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

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
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(
            label,
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
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 20, color: Colors.white.withOpacity(0.85)),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
