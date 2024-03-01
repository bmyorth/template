import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../themes/colors_theme.dart';

class PickImangenForm extends StatefulWidget {
  const PickImangenForm({super.key});

  @override
  State<PickImangenForm> createState() => _PickImangenFormState();
}

class _PickImangenFormState extends State<PickImangenForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 40.0, bottom: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Material(
                                      color: Colors.black12,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: InkWell(
                                          // splashColor: primaryColor,
                                          highlightColor: AppColors.primary,
                                          onTap: !isLoading
                                              ? () => {seleccionarFoto(context)}
                                              : null,
                                          child: const SizedBox(
                                              width: 60,
                                              height: 60,
                                              // padding: EdgeInsets.all(13.0),
                                              child: Icon(
                                                Icons.image_rounded,
                                                color: AppColors.primary,
                                                size: 40,
                                              ))),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    const Text(
                                      'Galería',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 40.0,
                                ),
                                Column(
                                  children: [
                                    Material(
                                      color: Colors.black12,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: InkWell(
                                          // splashColor: primaryColor,
                                          highlightColor: AppColors.primary,
                                          onTap: !isLoading
                                              ? () => {tomarFoto(context)}
                                              : null,
                                          child: const SizedBox(
                                              width: 60,
                                              height: 60,
                                              // padding: EdgeInsets.all(13.0),
                                              child: Icon(
                                                Icons.camera_alt_rounded,
                                                color: AppColors.primary,
                                                size: 40,
                                              ))),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    const Text(
                                      'Cámara',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        loading()
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  right: 5.0,
                  top: 5.0,
                  child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close)))
            ],
          ),
        ),
      ),
    );
  }

  void seleccionarFoto(context) async {
    Get.back(result: ImageSource.gallery);
  }

  void tomarFoto(context) async {
    Get.back(result: ImageSource.camera);
  }

  Widget loading() {
    if (isLoading) {
      return const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            )
          ]);
    } else {
      return Container();
    }
  }
}
