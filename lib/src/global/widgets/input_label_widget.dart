import 'package:flutter/material.dart';

import '../../themes/colors_theme.dart';
//..

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textColorDark,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
