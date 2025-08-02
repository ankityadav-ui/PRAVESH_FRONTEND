import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/warden/warden_students_outside_screen.dart';
import 'package:pravesh_screen/warden/LateEntryRequestsScreen.dart';
import 'package:pravesh_screen/warden/MyGate.dart';

class WardenHomeScreen extends StatelessWidget {
  const WardenHomeScreen({super.key});

  // Dynamic greeting based on time
  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  // Current time formatted
  String get _currentTime {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.035,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header (same style as Teacher)
              Row(
                children: [
                  // Greeting
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello Mr. Harsh Goud",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: colors.white.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        _greeting,
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          color: colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Time + Location
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _currentTime,
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          color: colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        "Nagpur, Maharashtra",
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        
              SizedBox(height: screenHeight * 0.03),
        
              // Counters
              Row(
                children: [
                  _infoCard(context, "Students Outside", "3", Icons.groups),
                  SizedBox(width: screenWidth * 0.04),
                  _infoCard(context, "Late Requests", "2", Icons.warning_amber),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),
        
              // Urgent Alert
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
                        Icon(Icons.error_outline, color: Colors.red, size: screenWidth * 0.06),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "Urgent: Late Entry Requests",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "2 student(s) requesting late entry permission",
                      style: TextStyle(color: colors.white, fontSize: screenWidth * 0.035),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(double.infinity, screenHeight * 0.06),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LateEntryRequestsScreen()),
                        );
                      },
                      child: Text("Review Requests", style: TextStyle(fontSize: screenWidth * 0.04)),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentsOutsideScreen()),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              _wideButton(
                context,
                label: "My Gate (2 Pending)",
                icon: Icons.shield,
                color: colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyGateVisitorsScreen()),
                  );
                },
              ),
            ],
          ),
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
            Icon(icon, color: colors.white, size: screenWidth * 0.06),
            SizedBox(height: screenWidth * 0.015),
            Text(
              count,
              style: TextStyle(
                color: colors.green,
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.white.withOpacity(0.8),
                fontSize: screenWidth * 0.03,
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
      icon: Icon(icon, color: Colors.white, size: screenWidth * 0.06),
      label: Text(
        label,
        style: TextStyle(fontSize: screenWidth * 0.04),
      ),
    );
  }
}