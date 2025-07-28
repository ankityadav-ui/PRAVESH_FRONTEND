import 'package:flutter/material.dart';
import 'package:pravesh_screen/widgets/color.dart';
import 'package:pravesh_screen/app_colors_provider.dart'; // for appColors(context)

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
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Students requesting entry after 8:00 PM',
              style: TextStyle(
                color: colors.hintText,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: lateEntries.length,
                itemBuilder: (context, index) {
                  final entry = lateEntries[index];
                  return _buildRequestCard(entry, colors);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(Map<String, String> entry, AppColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.box,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: colors.red, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry["name"] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.meeting_room,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(entry["room"] ?? '',
                            style: TextStyle(color: colors.hintText)),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '⚠ URGENT',
                style: TextStyle(
                  color: colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text('Requested at: ${entry["requestedAt"]}',
                  style: TextStyle(color: colors.hintText)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text('Expected return: ${entry["expectedReturn"]}',
                  style: TextStyle(color: colors.hintText)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Reason for delay:\n${entry["reason"] ?? ''}',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('ID: ${entry["id"]}', style: TextStyle(color: colors.hintText)),
              const Spacer(),
              Text(entry["phone"] ?? '', style: TextStyle(color: colors.hintText)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {
                    // TODO: Approve action
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Approve Entry"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.red,
                    side: BorderSide(color: colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {
                    // TODO: Deny action
                  },
                  icon: const Icon(Icons.close),
                  label: const Text("Deny"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
