import 'package:flutter/material.dart';
import 'package:pravesh_screen/widgets/color.dart';

AppColors appColors(BuildContext context) {
  final brightness = Theme.of(context).brightness;
  
  return AppColors(isDark: brightness == Brightness.dark);

}
