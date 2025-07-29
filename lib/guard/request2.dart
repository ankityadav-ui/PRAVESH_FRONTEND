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
          primary: Color(0xFFE5B84B), // Yellow for Pending
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Request Status',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Waiting for teacher response',
                style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: _buildStatusCard(context, pendingColor),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, Color pendingColor) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF273348),
        borderRadius: BorderRadius.circular(16),
      ),
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
          _buildPendingStatus(context, pendingColor),
        ],
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
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person, color: Colors.white70, size: 28),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Kunal Mohapatra',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 4),
            Text('Visitor Request',
                style: TextStyle(fontSize: 13, color: Colors.white70)),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
                letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ],
    );
  }

  Widget _buildPendingStatus(BuildContext context, Color pendingColor) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(pendingColor),
              strokeWidth: 5.0,
            ),
          ),
          const SizedBox(height: 16),
        ActionChip(
  avatar: Icon(Icons.access_time_filled, color: pendingColor, size: 16),
  label: const Text('PENDING'),
  labelStyle: TextStyle(
      color: pendingColor, fontWeight: FontWeight.bold, fontSize: 14),
  backgroundColor: pendingColor.withOpacity(0.15),
  shape: const StadiumBorder(),
  side: BorderSide(color: pendingColor.withOpacity(0.5)),
  padding: const EdgeInsets.symmetric(horizontal: 8),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RequestStatusSuccessScreen(),
      ),
    );
  },
),

          const SizedBox(height: 8),
          Text('Waiting for Prof. Johnson to respond...',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8), fontSize: 14)),
        ],
      ),
    );
  }
}
