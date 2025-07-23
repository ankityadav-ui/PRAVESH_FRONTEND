import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

class HeaderContainer extends StatelessWidget {
  final String text;

  const HeaderContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final colors = appColors(context);
    return Container(
      height: screenHeight * 0.4, // 40% of screen height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.greenDark, colors.green],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(screenWidth * 0.2), // 20% of screen width
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: screenHeight * 0.02, // 2% from bottom
            right: screenWidth * 0.05, // 5% from right
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.025, // 2.5% of screen height
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: screenWidth * 0.4, // 40% of screen width
              height: screenWidth * 0.4, // 40% of screen width (square logo)
              child: Image.asset("assets/icons/Logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
