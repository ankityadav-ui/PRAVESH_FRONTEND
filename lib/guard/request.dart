// Refactored request.dart for responsiveness
import 'package:flutter/material.dart';
import 'package:pravesh_screen/guard/new_visitor_managment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Status',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 52, 59, 72),
        fontFamily: 'Inter',
        primaryColor: const Color(0xFF34D17B),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
    const accentGreen = Color(0xFF34D17B);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: screenWidth * 0.04,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: screenWidth * 0.045),
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              'Waiting for teacher response',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: screenWidth * 0.035),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            _buildStatusCard(context, accentGreen),
            SizedBox(height: screenWidth * 0.075),
            _buildRegisterButton(context, accentGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, Color accentGreen) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF273348),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(screenWidth),
          SizedBox(height: screenWidth * 0.06),
          _buildDetailRow(screenWidth, 'MEETING WITH', 'Prof. Johnson'),
          SizedBox(height: screenWidth * 0.04),
          _buildDetailRow(screenWidth, 'REASON', 'Discussion'),
          SizedBox(height: screenWidth * 0.04),
          _buildDetailRow(screenWidth, 'REQUEST TIME', '07:56 PM'),
          SizedBox(height: screenWidth * 0.06),
          _buildApprovalStatus(screenWidth, accentGreen),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.125,
          height: screenWidth * 0.125,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.person, color: Colors.white70, size: screenWidth * 0.07),
        ),
        SizedBox(width: screenWidth * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kunal Mohapatra',
              style: TextStyle(
                fontSize: screenWidth * 0.042,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              'Visitor Request',
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(double screenWidth, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.03,
            color: Colors.white54,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.038,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildApprovalStatus(double screenWidth, Color accentGreen) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.check_circle, color: accentGreen, size: screenWidth * 0.16),
          SizedBox(height: screenWidth * 0.04),
          Chip(
            avatar: Icon(Icons.check, color: Colors.white, size: screenWidth * 0.04),
            label: Text('APPROVED', style: TextStyle(fontSize: screenWidth * 0.035)),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: accentGreen.withOpacity(0.2),
            shape: const StadiumBorder(),
            side: BorderSide(color: accentGreen, width: 1),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            'Request approved! Visitor can proceed.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, Color accentGreen) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GuardDashboardScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: accentGreen,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          'Register New Visitor',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1F2A),
          ),
        ),
      ),
    );
  }
}