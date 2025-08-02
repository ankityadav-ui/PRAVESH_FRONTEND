// Refactored request2.dart for responsiveness
import 'package:flutter/material.dart';
import 'package:pravesh_screen/guard/request.dart';

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
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFFE5B84B),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleMedium: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          titleSmall: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
      home: const RequestStatusScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pendingColor = Theme.of(context).colorScheme.primary;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: screenWidth * 0.04,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Request Status',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: screenWidth * 0.045)),
            SizedBox(height: screenWidth * 0.01),
            Text('Waiting for teacher response',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: screenWidth * 0.035)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: _buildStatusCard(context, pendingColor),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, Color pendingColor) {
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
          _buildPendingStatus(context, pendingColor),
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
            Text('Kunal Mohapatra',
                style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: screenWidth * 0.01),
            Text('Visitor Request',
                style: TextStyle(fontSize: screenWidth * 0.032, color: Colors.white70)),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(double screenWidth, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Colors.white54,
                letterSpacing: 0.5)),
        SizedBox(height: screenWidth * 0.01),
        Text(value,
            style: TextStyle(
                fontSize: screenWidth * 0.038,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ],
    );
  }

  Widget _buildPendingStatus(BuildContext context, Color pendingColor) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(pendingColor),
              strokeWidth: 5.0,
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          ActionChip(
            avatar: Icon(Icons.access_time_filled, color: pendingColor, size: screenWidth * 0.04),
            label: Text('PENDING', style: TextStyle(fontSize: screenWidth * 0.035)),
            labelStyle: TextStyle(
                color: pendingColor, fontWeight: FontWeight.bold),
            backgroundColor: pendingColor.withOpacity(0.15),
            shape: const StadiumBorder(),
            side: BorderSide(color: pendingColor.withOpacity(0.5)),
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequestStatusSuccessScreen(),
                ),
              );
            },
          ),
          SizedBox(height: screenWidth * 0.02),
          Text('Waiting for Prof. Johnson to respond...',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8), fontSize: screenWidth * 0.035)),
        ],
      ),
    );
  }
}