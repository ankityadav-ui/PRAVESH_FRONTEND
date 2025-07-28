import 'package:flutter/material.dart';
import 'package:pravesh_screen/guard/new_visitor_managment.dart';

void main() {
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Status',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1F2A),
        primaryColor: const Color(0xFF34D17B),
        fontFamily: 'sans-serif',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(color: Colors.white70),
        ),
      ),
      home: const RequestStatusSuccessScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RequestStatusSuccessScreen extends StatelessWidget {
  const RequestStatusSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Waiting for teacher response',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatusCard(context),
            const SizedBox(height: 24),
            _buildRegisterButton(context), // ✅ Pass context here
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return Card(
      color: const Color(0xFF273348),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildDetailRow('MEETING WITH', 'Prof. Johnson'),
            const SizedBox(height: 16),
            _buildDetailRow('REASON', 'Discussion'),
            const SizedBox(height: 16),
            _buildDetailRow('REQUEST TIME', '07:56 PM'),
            const SizedBox(height: 24),
            _buildApprovalStatus(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFC4C4C4).withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person, color: Colors.white70, size: 30),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kunal Mohapatra',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Visitor Request',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildApprovalStatus(BuildContext context) {
    final Color approvalColor = Theme.of(context).primaryColor;
    return Center(
      child: Column(
        children: [
          Icon(Icons.check_circle, color: approvalColor, size: 60),
          const SizedBox(height: 16),
          Chip(
            avatar: const Icon(Icons.check, color: Colors.white, size: 16),
            label: const Text('APPROVED'),
            labelStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            backgroundColor: approvalColor.withOpacity(0.25),
            shape: const StadiumBorder(),
            side: BorderSide(color: approvalColor),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          const SizedBox(height: 8),
          Text(
            'Request approved! Visitor can proceed.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) { // ✅ context is passed here
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuardDashboardScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF34D17B),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Register New Visitor',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1F2A),
          ),
        ),
      ),
    );
  }
}
