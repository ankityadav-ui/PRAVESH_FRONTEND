import 'package:flutter/material.dart';
import 'package:pravesh_screen/widgets/color.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

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
            fontSize: screenWidth * 0.05,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Currently ${students.length} students are outside',
              style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035),
            ),
            SizedBox(height: screenWidth * 0.03),
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.03),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: colors.box,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.grey),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.06,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: screenWidth * 0.06),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      student["name"] ?? '',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colors.green,
                      ),
                      child: Text(
                        'Outside',
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.015),
                _buildInfoRow(screenWidth, Icons.meeting_room, student["room"] ?? '', colors),
                SizedBox(height: screenWidth * 0.01),
                _buildInfoRow(screenWidth, Icons.access_time, 'Left at: ${student["leftAt"]}', colors),
                SizedBox(height: screenWidth * 0.01),
                _buildInfoRow(screenWidth, Icons.location_on, 'Last seen: ${student["lastSeen"]}', colors),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
                    Text('ID: ${student["id"]}', style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
                    const Spacer(),
                    Text(student["phone"] ?? '', style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(double screenWidth, IconData icon, String text, AppColors colors) {
    return Row(
      children: [
        Icon(icon, size: screenWidth * 0.035, color: colors.hintText),
        SizedBox(width: screenWidth * 0.01),
        Text(text, style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
      ],
    );
  }
}