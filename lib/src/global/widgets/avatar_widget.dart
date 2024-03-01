// ignore: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/message/app_message.dart';
import '../../themes/colors_theme.dart';
import '../global_controller.dart';
import 'view_imagen_widget.dart';

typedef OnPressValue<T> = void Function();

class AvatarWidget extends StatelessWidget {
  final String? url;
  final double size;
  final OnPressValue? onPress;
  final bool loading;
  final bool border;

  const AvatarWidget({
    super.key,
    this.url,
    this.size = 120,
    this.onPress,
    this.loading = false,
    this.border = true,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(

        // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
        builder: (controller) => Container(
            margin: const EdgeInsets.only(right: 0.0),
            padding: const EdgeInsets.all(0.0),
            // color: Colors.red,
            height: size,
            width: size,
            child: url != null
                ? Container(
                    decoration: border
                        ? BoxDecoration(
                            // color: Theme.of(context).primaryColor,
                            border: Border.all(
                                color: AppColors.primary, width: 6.0),
                            shape: BoxShape.circle,
                          )
                        : null,
                    height: size,
                    width: size,
                    child: Container(
                      //ClipOval
                      child: url!.contains('https://') ||
                              url!.contains('http://')
                          ? CachedNetworkImage(
                              imageUrl: url!,
                              // httpHeaders: <String, String>{
                              //   "Authorization": controller.userToken,
                              //   'Content-Type': 'application/json',
                              // },
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Icon(
                                  Icons.image_outlined,
                                  size: 50.0,
                                ),
                              ),
                              imageBuilder: (context, imageProvider) => Hero(
                                  tag: 'profile',
                                  child: GestureDetector(
                                    onTap: () {
                                      if (onPress != null) {
                                        onPress?.call();
                                      } else {
                                        AppMessage.service.customDialog(
                                          widget: ViewImagen(
                                            imagen: url!,
                                          ),
                                        );
                                      }
                                    },
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: loading
                                            ? const CircularProgressIndicator()
                                            : Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )),
                                  )),
                              // width: size,
                              // height: size,
                            )
                          : GestureDetector(
                              onTap: () {
                                if (onPress != null) {
                                  onPress?.call();
                                } else {
                                  AppMessage.service.customDialog(
                                    widget: ViewImagen(
                                      imagen: url!,
                                      isAsset: true,
                                      isLocal: true,
                                    ),
                                  );
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(url!),
                              ),
                            ),
                    ),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.person))));
  }
}
