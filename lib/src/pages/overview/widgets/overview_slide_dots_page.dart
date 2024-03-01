import 'package:flutter/material.dart';
//...

class OverviewSlideDots extends StatelessWidget {
  const OverviewSlideDots({
    super.key,
    required this.length,
    required this.currentPage,
  });

  final int length;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 5),
          width: index == currentPage ? 25 : 10,
          height: 7,
          decoration: BoxDecoration(
            color: index == currentPage ? Colors.black : Colors.black38,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
