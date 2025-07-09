import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:flutter/animation.dart';
import 'package:pravesh_screen/widgets/color.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _imageScaleAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _imageScaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
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
          // Background Circles
          Positioned(
            top: -0.2 * height,
            right: -0.2 * width,
            child: Container(
              width: 0.5 * height,
              height: 0.5 * height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.green.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -0.3 * height,
            left: -0.2 * width,
            child: Container(
              width: 0.6 * height,
              height: 0.6 * height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.green.withOpacity(0.05),
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(height: 0.1 * height),

              // Hero Image
              ScaleTransition(
                scale: _imageScaleAnimation,
                child: Container(
                  width: width,
                  height: 0.45 * height,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colors.green.withOpacity(0.2),
                        blurRadius: 0.025 * height,
                        spreadRadius: 0.002 * height,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.01 * height),
                    child: Image.asset(
                      'assets/images/first.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            color: colors.red,
                            size: 0.1 * height,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 0.05 * height),

              // Text Content
              SlideTransition(
                position: _textSlideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.1 * width),
                    child: Column(
                      children: [
                        Text(
                          'Military-Grade',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: introWhite,
                            fontSize: 0.035 * height,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            height: 1.3,
                          ),
                        ),
                        Text(
                          'Digital Security',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.green,
                            fontSize: 0.035 * height,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 0.02 * height),
                        Text(
                          'Experience top-notch protection with our advanced '
                          'QR technology. Your data stays encrypted and secure.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: introWhite.withOpacity(0.8),
                            fontSize: 0.02 * height,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                            height: 1.5,
                          ),
                        ),
                      ],
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
