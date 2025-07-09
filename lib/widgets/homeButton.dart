import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double screenWidth;
  final double screenHeight;

  const HomeButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        height: widget.screenHeight * 0.1, // 10% of screen height
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0ACF83),
          borderRadius: BorderRadius.circular(
              widget.screenWidth * 0.04), // 4% of screen width
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                widget.screenWidth * 0.04), // 4% of screen width
            color:
                _isPressed ? Colors.black.withOpacity(0.2) : Colors.transparent,
          ),
          child: Center(
            child: Text(
              widget.buttonName,
              style: TextStyle(
                fontSize: widget.screenWidth * 0.055, // 5.5% of screen width
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
