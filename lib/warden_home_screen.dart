import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/warden_students_outside_screen.dart';
import 'package:pravesh_screen/LateEntryRequestsScreen.dart';

class WardenHomeScreen extends StatelessWidget {
  const WardenHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.035,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Greeting & Weather
            Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.07,
                  backgroundColor: colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: screenWidth * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Mr.Harsh Goud",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: colors.white,
                      ),
                    ),
                    Text(
                      "Good Evening!",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                // Column(
                //   children: [
                //     Icon(Icons.sunny, color: Colors.amber),
                //     Text(
                //       "22°",
                //       style: TextStyle(
                //         color: colors.white,
                //         fontSize: screenWidth * 0.035,
                //       ),
                //     ),
                //     Text(
                //       "London",
                //       style: TextStyle(
                //         color: colors.white.withOpacity(0.7),
                //         fontSize: screenWidth * 0.03,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            // Counters Row
            Row(
              children: [
                _infoCard(context, "Students Outside", "3", Icons.groups),
                SizedBox(width: screenWidth * 0.04),
                _infoCard(context, "Late Requests", "2", Icons.warning_amber),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),

            // Urgent Alert Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.045),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Urgent: Late Entry Requests",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "2 student(s) requesting late entry permission",
                    style: TextStyle(color: colors.white),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Review Requests"),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),

            // Buttons
            _wideButton(
              context,
              label: "Students Outside (3)",
              icon: Icons.groups,
              color: Colors.blue,
              onTap: () { Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentsOutsideScreen()),
    );},
            ),
            SizedBox(height: screenHeight * 0.015),
            _wideButton(
              context,
              label: "My Gate (2 Pending)",
              icon: Icons.shield,
              color: colors.green,
              onTap: () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LateEntryRequestsScreen()),
    );},
            ),
            SizedBox(height: screenHeight * 0.025),

            // Bottom Row Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _smallButton(context, label: "Room Status", icon: Icons.bed),
                _smallButton(context,
                    label: "Announcements", icon: Icons.campaign),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(
      BuildContext context, String label, String count, IconData icon) {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: colors.box,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: colors.white),
            SizedBox(height: 6),
            Text(
              count,
              style: TextStyle(
                color: colors.green,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: colors.white.withOpacity(0.8),
                fontSize: screenWidth * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wideButton(BuildContext context,
      {required String label,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, screenWidth * 0.14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: TextStyle(fontSize: screenWidth * 0.04),
      ),
    );
  }

  Widget _smallButton(BuildContext context,
      {required String label, required IconData icon}) {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;
    double getFontSize(double base) => screenWidth < 360 ? base * 0.85 : base;

    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.box,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(screenWidth * 0.4, screenWidth * 0.12),
        ),
        icon: Icon(icon, color: colors.white, size: screenWidth * 0.06),
        label: Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: colors.white,
                fontSize: getFontSize(screenWidth * 0.035)),
          ),
        ),
      ),
    );
  }
}
