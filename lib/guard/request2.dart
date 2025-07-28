import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Status',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1F2A),
        fontFamily: 'sans-serif',
        // Define color scheme for consistency
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFFE5B84B), // Yellow for 'Pending'
        ),
      ),
      home: const RequestStatusScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// A stateless widget that renders the static UI for the pending request.
class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Request Status',
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Waiting for teacher response',
              style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildStatusCard(context),
      ),
    );
  }

  /// Builds the main status card.
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
            _buildDetailRow('REASON', 'd'),
            const SizedBox(height: 16),
            _buildDetailRow('REQUEST TIME', '07:56 PM'),
            const SizedBox(height: 24),
            _buildPendingStatus(context),
          ],
        ),
      ),
    );
  }

  /// Builds the header section with avatar and name.
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              'Visitor Request',
              style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
            ),
          ],
        ),
      ],
    );
  }

  /// A reusable widget for displaying a detail row.
  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5), letterSpacing: 0.5),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }
  
  /// Builds the UI for the 'Pending' status.
  Widget _buildPendingStatus(BuildContext context) {
    final Color pendingColor = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(pendingColor),
              strokeWidth: 5.0,
              strokeCap: StrokeCap.round,
            ),
          ),
          const SizedBox(height: 16),
          Chip(
            avatar: Icon(Icons.access_time_filled, color: pendingColor, size: 16),
            label: Text('PENDING', style: TextStyle(color: pendingColor, fontWeight: FontWeight.bold)),
            backgroundColor: pendingColor.withOpacity(0.15),
            shape: const StadiumBorder(),
            side: BorderSide(color: pendingColor.withOpacity(0.5)),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          const SizedBox(height: 8),
          Text(
            'Waiting for Prof. Johnson to respond...',
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
        ],
      ),
    );
  }
}