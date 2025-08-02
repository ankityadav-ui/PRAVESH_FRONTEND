import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

class ViewProfileScreen extends StatelessWidget {
  final String userName = "Ankit Yadav";
  final String userEmail = "bt24csd007@iiitn.ac.in";
  final String roomNo = "235";
  final String mobileNo = "7878356069";

  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final colors = appColors(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Student Profile",
          style: TextStyle(
            color: colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.055,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              // Profile Picture
              Center(
                child: Container(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.green,
                      width: screenWidth * 0.01,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/default_profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Profile Details
              _buildDetailCard(
                context: context,
                icon: Icons.person_outline,
                title: "Full Name",
                value: userName,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.025),

              _buildDetailCard(
                context: context,
                icon: Icons.email_outlined,
                title: "Email Address",
                value: userEmail,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.025),

              _buildDetailCard(
                context: context,
                icon: Icons.meeting_room_outlined,
                title: "Room Number",
                value: roomNo,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.025),

              _buildDetailCard(
                context: context,
                icon: Icons.phone_android_outlined,
                title: "Mobile Number",
                value: mobileNo,
                screenWidth: screenWidth,
              ),
            ],
          ),
        ),
      ), // If you have a custom nav bar
    );
  }

  Widget _buildDetailCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required double screenWidth,
  }) {
    final colors = appColors(context);
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.045),
      decoration: BoxDecoration(
        color: colors.box,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colors.green,
            size: screenWidth * 0.065,
          ),
          SizedBox(width: screenWidth * 0.045),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.white.withOpacity(0.6),
                    fontSize: screenWidth * 0.038,
                  ),
                ),
                SizedBox(height: screenWidth * 0.015),
                Text(
                  value,
                  style: TextStyle(
                    color: colors.white,
                    fontSize: screenWidth * 0.043,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
