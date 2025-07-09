import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

class ButtonWidget extends StatelessWidget {
  final String btnText;
  final VoidCallback? onClick; // Nullable if needed

  const ButtonWidget({Key? key, required this.btnText, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final colors = appColors(context);

    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity, // Still takes full available width
        height: screenHeight * 0.06, // 6% of screen height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.greenDark, colors.green],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(screenHeight * 0.03), // 3% of screen height
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: screenHeight * 0.025, // 2.5% of screen height
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
