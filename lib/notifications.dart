import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);
    return Scaffold(
      body: Container(
        color: colors.green,
      ),
    );
  }
}
