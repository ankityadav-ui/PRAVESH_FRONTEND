import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class HostelVisitor {
  const HostelVisitor({
    required this.name,
    required this.visitType,
    required this.location,
    required this.time,
    required this.tag,
  });

  final String name;
  final String visitType;
  final String location;
  final String time;
  final String tag;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Gate - Visitors',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1F2A),
        fontFamily: 'Inter',
      ),
      home: const MyGateVisitorsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyGateVisitorsScreen extends StatelessWidget {
  const MyGateVisitorsScreen({super.key});

  final List<HostelVisitor> _visitors = const [
    HostelVisitor(
      name: 'Mrs. Johnson',
      visitType: 'Parent Visit',
      location: 'A-204',
      time: '2:30 PM',
      tag: 'parent',
    ),
    HostelVisitor(
      name: 'Dr. Smith',
      visitType: 'Official Inspection',
      location: 'Warden Office',
      time: '3:00 PM',
      tag: 'official',
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
          onPressed: () {
            Navigator.pop(context); // ✅ Works now
          },
        ),
        title: const Text(
          'My Gate - Visitors',
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
              'Manage hostel visitor requests',
              style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _visitors.length,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _VisitorCard(visitor: _visitors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VisitorCard extends StatelessWidget {
  const _VisitorCard({required this.visitor});

  final HostelVisitor visitor;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section
          Row(
            children: [
              const CircleAvatar(radius: 24, backgroundColor: Color(0xFFE0E0E0)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          visitor.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        _buildTag(visitor.tag),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      visitor.visitType,
                      style: const TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Middle Section
          Row(
            children: [
              _buildDetailItem(Icons.location_on_outlined, visitor.location, secondaryTextColor),
              const SizedBox(width: 24),
              _buildDetailItem(Icons.access_time, visitor.time, secondaryTextColor),
            ],
          ),
          const SizedBox(height: 16),
          // Action Buttons
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
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    final Map<String, Color> tagColors = {
      'parent': const Color(0xFF2196F3),
      'official': const Color(0xFF9C27B0),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tagColors[tag] ?? Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
