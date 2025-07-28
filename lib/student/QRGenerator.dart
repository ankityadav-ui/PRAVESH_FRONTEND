import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  final String encryptedData;

  const QRCodeGenerator({super.key, required this.encryptedData});

  @override
  State<QRCodeGenerator> createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  int _remainingTime = 300; // 30 seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          _showTimeLimitExceededDialog();
        }
      });
    });
  }

  void _showTimeLimitExceededDialog() {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final Color primaryColor = colors.green;
    final Color cardColor = colors.box;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardColor,
          title: Text(
            'QR Expired',
            style: TextStyle(
              color: colors.white,
              fontSize: screenWidth * 0.05,
            ),
          ),
          content: Text(
            'This QR code is no longer valid. Please generate a new one if needed.',
            style: TextStyle(
              color: colors.hintText,
              fontSize: screenWidth * 0.04,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 30;
    int remainingSeconds = seconds % 30;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> qrData = {
      "name": "abc",
      "username": "ese",
      "user_id": "bt24cseXXX",
      "phone_numebr": 123456789,
      "type": "exit"
    };

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final colors = appColors(context);
    final Color primaryColor = colors.green;
    final Color backgroundColor = colors.background;
    final Color cardColor = colors.box;

    // Percentage-based calculations
    final double horizontalPadding = screenWidth * 0.05;
    final double verticalPadding = screenHeight * 0.03;
    final double subtitleFontSize = screenWidth * 0.04;
    final double timerLabelFontSize = screenWidth * 0.04;
    final double instructionFontSize = screenWidth * 0.045;
    final double buttonFontSize = screenWidth * 0.045;
    final double smallSpacing = screenHeight * 0.01;
    final double buttonHorizontalPadding = screenWidth * 0.06;
    final double buttonVerticalPadding = screenHeight * 0.02;
    final double qrPadding = screenWidth * 0.05;
    final double qrSize = screenWidth * 0.7;
    final double borderRadius = screenWidth * 0.03;
    final double iconSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'SCAN QR CODE',
          style: TextStyle(
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
            color: colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header Section
              Column(
                children: [
                  Text(
                    'Show this QR code at the gate while exiting',
                    style: TextStyle(
                      color: colors.hintText,
                      fontSize: subtitleFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              // Timer Card
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: buttonHorizontalPadding,
                  vertical: buttonVerticalPadding,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'TIME REMAINING',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: timerLabelFontSize,
                      ),
                    ),
                    SizedBox(width: smallSpacing),
                    Text(
                      _formatTime(_remainingTime),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: timerLabelFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // QR Code Container
              Container(
                width: screenWidth * 0.65,
                height: screenWidth * 0.65,
                padding: EdgeInsets.all(qrPadding),
                decoration: BoxDecoration(
                  color: colors.white,
                  borderRadius: BorderRadius.circular(borderRadius * 2),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: QrImageView(
                  data: widget.encryptedData,
                  version: QrVersions.auto,
                  size: qrSize,
                  foregroundColor: colors.background,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Instruction Text
              Text(
                'Scan before the timer expires',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: instructionFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Home Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop((context));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenWidth * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.home, size: iconSize, color: colors.white),
                        SizedBox(width: smallSpacing),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: buttonFontSize,
                            color: colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
