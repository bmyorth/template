import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors_theme.dart';

//...

class ViewImagen extends StatefulWidget {
  const ViewImagen(
      {super.key,
      this.tag = 'imagen',
      this.isLocal = false,
      this.isAsset = false,
      required this.imagen});

  final String tag;
  final bool isLocal;
  final bool isAsset;
  final String imagen;

  @override
  _ViewImagenState createState() => _ViewImagenState();
}

class _ViewImagenState extends State<ViewImagen> with TickerProviderStateMixin {
  AnimationController? animationController1;
  AnimationController? animationController2;
  AnimationController? animationController3;
  AnimationController? animationController4;
  Animation<double>? animation1;
  Animation<double>? animation2;
  Animation<double>? animation3;
  Animation<double>? animation4;
  int rotateTime = 0;
  bool isRotate = false;

  @override
  void initState() {
    animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animationController3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animationController4 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation1 =
        Tween<double>(begin: 0, end: pi / 2).animate(animationController1!);
    animation2 =
        Tween<double>(begin: pi / 2, end: pi).animate(animationController2!);
    animation3 = Tween<double>(begin: pi, end: pi + pi / 2)
        .animate(animationController3!);
    animation4 = Tween<double>(begin: pi + pi / 2, end: pi + pi)
        .animate(animationController4!);
    super.initState();
  }

  _rotateChildContinuously() {
    setState(() {
      rotateTime++;
      if (rotateTime == 1) {
        animationController1!.forward(from: 0);
      } else if (rotateTime == 2) {
        animationController2!.forward(from: 0);
      } else if (rotateTime == 3) {
        animationController3!.forward(from: 0);
      } else if (rotateTime == 4) {
        animationController4!.forward(from: 0);
      }
    });
  }

  Animation<double>? buildAnimation() {
    if (rotateTime == 1 || rotateTime == 0) {
      return animation1;
    } else if (rotateTime == 2) {
      return animation2;
    } else if (rotateTime == 3) {
      return animation3;
    } else if (rotateTime == 4) {
      rotateTime = 0;
      return animation4;
    }
    return animation1;
  }

  @override
  void dispose() {
    super.dispose();
    animationController1?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: Stack(
          children: [
            Container(
              color: AppColors.backgroundApp,
              padding: EdgeInsets.zero,
              width: double.infinity,
              height: double.infinity,
              child: Hero(
                tag: widget.tag,
                child: InteractiveViewer(
                  child: RotateTrans(
                      animation: buildAnimation()!,
                      child: widget.isLocal
                          ? widget.isAsset
                              ? Image.asset(
                                  widget.imagen,
                                  fit: BoxFit.contain,
                                  // height: height - 70.0,
                                )
                              : Image.file(
                                  File(widget.imagen),
                                  fit: BoxFit.contain,
                                )
                          : CachedNetworkImage(
                              imageUrl: widget.imagen,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.contain,
                            )),
                ),
              ),
            ),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: _rotateChildContinuously,
                    icon: const Icon(
                      Icons.rotate_right_outlined,
                      size: 30.0,
                    ),
                    splashRadius: 20.0,
                  ),
                )),
          ],
        ),
        onTap: () {
          Get.back();
        },
      ),
    );
  }
}

class RotateTrans extends StatelessWidget {
  final Widget? child;
  final Animation<double>? animation;
  const RotateTrans({super.key, this.child, this.animation});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      child: child,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation!.value,
          child: child,
        );
      },
    );
  }
}
