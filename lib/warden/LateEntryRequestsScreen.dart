import 'package:flutter/material.dart';
import 'package:pravesh_screen/widgets/color.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

class LateEntryRequestsScreen extends StatelessWidget {
  const LateEntryRequestsScreen({super.key});

  final List<Map<String, String>> lateEntries = const [
    {
      "name": "Sarah Chen",
      "room": "Room A-102",
      "requestedAt": "8:45 PM",
      "expectedReturn": "9:30 PM",
      "reason":
          "Medical emergency - had to visit hospital for family member",
      "id": "ST2024004",
      "phone": "+44 7123 456792",
    },
    {
      "name": "David Kumar",
      "room": "Room B-205",
      "requestedAt": "8:20 PM",
      "expectedReturn": "9:00 PM",
      "reason":
          "Train delay due to technical issues, stuck at station",
      "id": "ST2024005",
      "phone": "+44 7123 456793",
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
          'Late Entry Requests',
          style: TextStyle(
            color: colors.white,
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Students requesting entry after 8:00 PM',
              style: TextStyle(
                color: colors.hintText,
                fontSize: screenWidth * 0.035,
              ),
            ),
            SizedBox(height: screenWidth * 0.03),
            Expanded(
              child: ListView.builder(
                itemCount: lateEntries.length,
                itemBuilder: (context, index) {
                  final entry = lateEntries[index];
                  return _buildRequestCard(context, entry, colors);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Map<String, String> entry, AppColors colors) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.035),
      decoration: BoxDecoration(
        color: colors.box,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: colors.red, width: screenWidth * 0.007),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.055,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: screenWidth * 0.06),
              ),
              SizedBox(width: screenWidth * 0.025),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry["name"] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                        color: colors.white,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Row(
                      children: [
                        Icon(Icons.meeting_room,
                            size: screenWidth * 0.035, color: Colors.grey),
                        SizedBox(width: screenWidth * 0.01),
                        Text(entry["room"] ?? '',
                            style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '⚠ URGENT',
                style: TextStyle(
                  color: colors.red,
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            children: [
              Icon(Icons.schedule, size: screenWidth * 0.035, color: Colors.grey),
              SizedBox(width: screenWidth * 0.01),
              Text('Requested at: ${entry["requestedAt"]}',
                  style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          Row(
            children: [
              Icon(Icons.timer_outlined, size: screenWidth * 0.035, color: Colors.grey),
              SizedBox(width: screenWidth * 0.01),
              Text('Expected return: ${entry["expectedReturn"]}',
                  style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
            ],
          ),
          SizedBox(height: screenWidth * 0.025),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Reason for delay:\n${entry["reason"] ?? ''}',
              style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.035),
            ),
          ),
          SizedBox(height: screenWidth * 0.025),
          Row(
            children: [
              Text('ID: ${entry["id"]}', style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
              const Spacer(),
              Text(entry["phone"] ?? '', style: TextStyle(color: colors.hintText, fontSize: screenWidth * 0.035)),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.green,
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // TODO: Approve action
                  },
                  icon: Icon(Icons.check, size: screenWidth * 0.04),
                  label: Text("Approve Entry", style: TextStyle(fontSize: screenWidth * 0.03)),
                ),
              ),
              SizedBox(width: screenWidth * 0.025),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.red,
                    side: BorderSide(color: colors.red, width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // TODO: Deny action
                  },
                  icon: Icon(Icons.close, size: screenWidth * 0.04),
                  label: Text("Deny", style: TextStyle(fontSize: screenWidth * 0.03)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}