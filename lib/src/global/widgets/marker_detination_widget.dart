import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class MarkerDetinationWidget extends StatelessWidget {
  const MarkerDetinationWidget({super.key, this.isPulsed = false});
  final bool isPulsed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        isPulsed
            ? LoadingAnimationWidget.beat(color: Colors.black, size: 20.0)
            : const SizedBox.shrink(),
        const Icon(
          Icons.my_location_sharp,
          size: 30.0,
        ),
      ],
    );
  }
}
