import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Data Model to represent a single visitor request for clean code
class VisitorRequest {
  const VisitorRequest({
    required this.name,
    required this.reason,
    required this.room,
    required this.id,
    required this.time,
  });

  final String name;
  final String reason;
  final String room;
  final String id;
  final String time;
}

// --- Main Application ---
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor Requests',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1F2A),
        fontFamily: 'Inter',
      ),
      home: const VisitorRequestsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// --- The Screen Widget ---
class VisitorRequestsScreen extends StatelessWidget {
  const VisitorRequestsScreen({super.key});

  // Dummy data to populate the list, matching the design
  final List<VisitorRequest> _requests = const [
    VisitorRequest(
      name: 'Sarah Johnson',
      reason: 'Assignment Discussion',
      room: 'Room 204',
      id: 'ST2024001',
      time: '2:30 PM',
    ),
    VisitorRequest(
      name: 'Mike Chen',
      reason: 'Project Consultation',
      room: 'Room 204',
      id: 'ST2024002',
      time: '2:45 PM',
    ),
    VisitorRequest(
      name: 'Emma Davis',
      reason: 'Exam Query',
      room: 'Room 204',
      id: 'ST2024003',
      time: '3:00 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Visitor Requests',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              'Manage pending visitor requests',
              style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _requests.length,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _RequestCard(request: _requests[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Request Card Widget ---
class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});

  final VisitorRequest request;

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF273348);
    const acceptColor = Color(0xFF34D17B);
    const rejectColor = Color(0xFFF44336);
    const secondaryTextColor = Color(0xFF9E9E9E);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Top section: Avatar, Name, Reason, and Time
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(radius: 24, backgroundColor: Color(0xFFE0E0E0)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      request.reason,
                      style: const TextStyle(fontSize: 14, color: secondaryTextColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildDetailItem(Icons.access_time, request.time, secondaryTextColor, 14),
            ],
          ),
          const SizedBox(height: 16),
          // Middle section: Room and ID details with corrected spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDetailItem(Icons.location_on_outlined, request.room, secondaryTextColor, 13),
              const SizedBox(width: 40), // Corrected, fixed spacing
              _buildDetailItem(Icons.person_outline, request.id, secondaryTextColor, 13),
            ],
          ),
          const SizedBox(height: 16),
          // Bottom section: Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle, size: 18),
                  label: const Text('Accept'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: acceptColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.cancel, size: 18),
                  label: const Text('Reject'),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: rejectColor,
                    side: const BorderSide(color: rejectColor, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// A helper widget to create the small icon-and-text details.
  Widget _buildDetailItem(IconData icon, String text, Color color, double size) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: size + 3),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}