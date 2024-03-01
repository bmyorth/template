import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/system/system_service.dart';
import '../../themes/colors_theme.dart';
import '../../types/app_types.dart';
import '../global_controller.dart';

// ...
typedef OnPress = void Function();

class ButtonApp extends StatefulWidget {
  final String text;
  final dynamic textColor;
  final OnPress? onPress;
  final dynamic icon;
  final BUTTONTYPE type;
  final double height;
  final double? width;
  final bool isPadding;
  final double textSize;

  const ButtonApp(
      {super.key,
      required this.text,
      this.onPress,
      this.type = BUTTONTYPE.PRIMARY,
      this.textColor = Colors.white,
      this.height = 50.0,
      this.width,
      this.icon,
      this.isPadding = true,
      this.textSize = 18.0});

  @override
  // ignore: library_private_types_in_public_api
  _ButtonAppState createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  Color? textColor;
  Color? background;
  Color? border;

  @override
  void initState() {
    getDecoration();
    super.initState();
  }

  void getDecoration() {
    switch (widget.type) {
      case BUTTONTYPE.PRIMARY:
        textColor = Colors.white;
        background = AppColors.primary;
        border = background;
        break;
      case BUTTONTYPE.SECUNDARY:
        textColor = AppColors.textColorDark;
        background = AppColors.secondary;
        border = background;
        break;
      case BUTTONTYPE.ACCENT:
        textColor = AppColors.textColorDark;
        background = AppColors.accent;
        border = background;
        break;
      case BUTTONTYPE.WHITE:
        textColor = AppColors.textColorDark;
        background = Colors.white;
        border = textColor;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    // ...
    return GetBuilder<GlobalController>(
        init: GlobalController(),
        builder: (_) {
          return Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: background,
                  shadowColor: AppColors.secondary,
                  elevation: 2.0,
                ),
                onPressed: _.connectionStatus.value.isSuccess
                    ? widget.onPress
                    : () => AppSystem.service.mensajeSinConexion(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  height: widget.height,
                  // width: widget.width != null ? widget.width : double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.icon != null
                          ? Row(
                              children: [
                                widget.icon,
                                const SizedBox(
                                  width: 8.0,
                                ),
                              ],
                            )
                          : Container(),
                      Text(
                        widget.text,
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
