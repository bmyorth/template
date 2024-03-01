import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ConnectionWidget extends StatefulWidget {
  const ConnectionWidget({super.key, required this.connectionStatus});
  final RxStatus connectionStatus;

  @override
  State<ConnectionWidget> createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  Color background = Colors.white;
  Color color = Colors.white;
  String message = '';
  double height = 30.0;
  bool hidden = false;
  @override
  Widget build(BuildContext context) {
    hidden = false;
    if (widget.connectionStatus.isSuccess) {
      background = Colors.green;
      color = color;
      message = 'Conectado';
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          hidden = true;
          height = 0.0;
        });
      });
    }

    if (widget.connectionStatus.isLoading) {
      background = Colors.grey;
      message = 'Verificando';
      color = color;
      height = 30.0;
    }

    if (widget.connectionStatus.isError) {
      background = Colors.redAccent;
      message = 'Desconectado';
      color = color;
      height = 30.0;
    }

    return message.isNotEmpty
        ? AnimatedContainer(
            height: height,
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              color: background,
            ),
            curve: Curves.fastOutSlowIn,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hidden
                    ? const SizedBox.shrink()
                    : Text(
                        message,
                        style: TextStyle(color: color),
                      )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
