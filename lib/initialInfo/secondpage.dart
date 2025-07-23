import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/widgets/color.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({super.key});

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final colors = appColors(context);

    return Scaffold(
      backgroundColor: IntroBackground,
      body: Stack(
        children: [
          // Background decorative circles
          Positioned(
            top: -height * 0.15,
            left: -width * 0.2,
            child: Container(
              width: height * 0.4,
              height: height * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.green.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -height * 0.25,
            right: -width * 0.15,
            child: Container(
              width: height * 0.5,
              height: height * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.green.withOpacity(0.05),
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(height: height * 0.1),

              // QR Image with animation
              SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    height: height * 0.35,
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(width * 0.05),
                      border: Border.all(
                        color: colors.green.withOpacity(0.3),
                        width: width * 0.005,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.green.withOpacity(0.2),
                          blurRadius: height * 0.02,
                          spreadRadius: height * 0.002,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/second_introp.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.error,
                          color: colors.red,
                          size: height * 0.1,
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.05),

              // Title
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    children: [
                      Text(
                        'Lightning Fast',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: introWhite,
                          fontSize: height * 0.035,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          height: 1.3,
                        ),
                      ),
                      Text(
                        'QR Scanning',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.green,
                          fontSize: height * 0.035,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),

              // Description
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Text(
                    'Our QR codes are designed for instant scanning with optimized patterns that work flawlessly in any condition.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: introWhite.withOpacity(0.8),
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
