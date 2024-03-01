import 'package:flutter/material.dart';

import '../../themes/colors_theme.dart';

class ButtonScreenWidget extends StatelessWidget {
  const ButtonScreenWidget({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });
  final String text;
  final IconData? icon;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed?.call();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Row(
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
