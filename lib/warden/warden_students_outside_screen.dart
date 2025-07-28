import 'package:flutter/material.dart';
import 'package:pravesh_screen/widgets/color.dart';
import 'package:pravesh_screen/app_colors_provider.dart'; // for appColors(context)

class StudentsOutsideScreen extends StatelessWidget {
  const StudentsOutsideScreen({super.key});

  final List<Map<String, String>> students = const [
    {
      "name": "Alex Johnson",
      "room": "Room A-204",
      "leftAt": "6:30 PM",
      "lastSeen": "City Center",
      "id": "ST2024001",
      "phone": "+44 7123 456789",
    },
    {
      "name": "Priya Sharma",
      "room": "Room B-156",
      "leftAt": "7:15 PM",
      "lastSeen": "Library",
      "id": "ST2024002",
      "phone": "+44 7123 456790",
    },
    {
      "name": "James Wilson",
      "room": "Room C-301",
      "leftAt": "5:45 PM",
      "lastSeen": "Shopping Mall",
      "id": "ST2024003",
      "phone": "+44 7123 456791",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: BackButton(color: colors.white),
        title: Text(
          'Students Outside Campus',
          style: TextStyle(
            color: colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Currently ${students.length} students are outside',
              style: TextStyle(color: colors.hintText, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return _buildStudentCard(context, student, colors);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, Map<String, String> student, AppColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.box,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.grey),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      student["name"] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colors.green,
                      ),
                      child: const Text(
                        'Outside',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.meeting_room, size: 14, color: colors.hintText),
                    const SizedBox(width: 4),
                    Text(student["room"] ?? '', style: TextStyle(color: colors.hintText)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: colors.hintText),
                    const SizedBox(width: 4),
                    Text('Left at: ${student["leftAt"]}', style: TextStyle(color: colors.hintText)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: colors.hintText),
                    const SizedBox(width: 4),
                    Text('Last seen: ${student["lastSeen"]}', style: TextStyle(color: colors.hintText)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('ID: ${student["id"]}', style: TextStyle(color: colors.hintText)),
                    const Spacer(),
                    Text(student["phone"] ?? '', style: TextStyle(color: colors.hintText)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
