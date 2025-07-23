import 'package:flutter/material.dart';
import 'package:pravesh_screen/QRGenerator.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/exitForm.dart';
import 'package:pravesh_screen/leaveForm.dart';
import 'package:pravesh_screen/themeNotifier.dart';
import 'package:pravesh_screen/widgets/navbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: colors.background,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              toolbarHeight: screenHeight * 0.12,
              backgroundColor: colors.background,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Navbar(initialIndex: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        decoration: BoxDecoration(
                          color: colors.green.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: colors.green,
                          size: screenWidth * 0.055,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Rishabh',
                          style: TextStyle(
                            color: colors.white,
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Good Evening!',
                          style: TextStyle(
                            color: colors.green,
                            fontSize: screenWidth * 0.032,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => themeNotifier.toggleTheme(),
                      icon: Icon(
                        themeNotifier.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Scan-Go-Grow',
                              style: TextStyle(
                                color: colors.white,
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              'Campus Exit',
                              style: TextStyle(
                                color: colors.green,
                                fontSize: screenWidth * 0.042,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      Column(
                        children: [
                          _CompactActionCard(
                            icon: Icons.exit_to_app,
                            title: 'Exit',
                            accentColor: colors.green,
                            onTap: () => _showExitDialog(context),
                            screenWidth: screenWidth,
                            boxColor: colors.box,
                            textColor: colors.white,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _CompactActionCard(
                            icon: Icons.login,
                            title: 'Enter',
                            accentColor: colors.green,
                            onTap: () => _showEnterDialog(context),
                            screenWidth: screenWidth,
                            boxColor: colors.box,
                            textColor: colors.white,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _CompactActionCard(
                            icon: Icons.nightlight_round,
                            title: 'Night Pass',
                            accentColor: colors.green,
                            onTap: () => _showNightPassDialog(context),
                            screenWidth: screenWidth,
                            boxColor: colors.box,
                            textColor: colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExitFormHomePage()),
    );
  }

  void _showEnterDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeGenerator(encryptedData: ''),
      ),
    );
  }

  void _showNightPassDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaveFormHomePage(title: '')),
    );
  }
}

class _CompactActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color accentColor;
  final Color boxColor;
  final Color textColor;
  final VoidCallback onTap;
  final double screenWidth;

  const _CompactActionCard({
    required this.icon,
    required this.title,
    required this.accentColor,
    required this.onTap,
    required this.screenWidth,
    required this.boxColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.04,
        ),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: accentColor,
                size: screenWidth * 0.055,
              ),
            ),
            SizedBox(width: screenWidth * 0.035),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: screenWidth * 0.042,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right,
                color: accentColor, size: screenWidth * 0.05),
          ],
        ),
      ),
    );
  }
}
