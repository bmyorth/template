import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../themes/colors_theme.dart';

//...

// ...

/// Tipo de dato utilizado por [Prompt.onConfirm]
typedef PromptTypeData<String> = void Function(String value);

/// Color del tema principal para los diferentes cuadros de
/// diálogos utilizados.
const Color appMessageThemeColor = Colors.black54;

/// Radio del borde del tema principal para los diferentes
/// cuadros de diálogos utilizados.
const double appMessageThemeRadius = 5;

/// Indica si el mensaje Toast estará situado en la parte superior [TOP]
/// o inferior [BOTTOM] de la pantalla.
enum ToastPosition { TOP, BOTTOM }

/// Indica el tipo de organización del elemento dentro del componente.
/// Si es [COL] se mostrara el elemento como una fila, similar a una
/// una lista de elementos. Por el contrario, si es [ROW], se mostrara
/// el elementos como una columna.
enum ActionSheetElementType { COL, ROW }

/// Servicio de mensajes personalizados basados en el uso del Framework
/// Reactivo [GetX] para renderizar y administrar los mismos.
class AppMessage {
  AppMessage._internal();
  static final AppMessage _instance = AppMessage._internal();

  /// Patrón Singleton para el servicio de mensajes, proporcionando una
  /// única intancia del servicio.
  static AppMessage get service => _instance;

  // Llave de estado del formulario el cual enviará
  // las credenciales y su observable para realizar
  // la auto-evaluación del formulario
  final GlobalKey<FormState> _formPromptKey = GlobalKey();
  final RxBool _formPromptAutovalidate = false.obs;
  String _formPromptValue = '';

  /// Cuadro de diálogo [SNACKBAR] que simula un mensaje de
  /// tipo toast [TOAST] o algun tipo de notificación.
  /// Ejemplo:
  ///
  /// ```dart
  /// AppMessage.service.toast(
  ///   icon: Icon(Icons.person),
  ///   title: 'Error',
  ///   message: 'Credenciales inválidas',
  ///   seconds: 5,
  ///   borderRadius: 10.0,
  ///   color: Colors.red,
  ///   position: ToastPosition.BOTTOM,
  ///   buttonActive: true,
  ///   buttonLabel: 'OK',
  ///   onButtonPress: () {},
  /// );
  /// ```
  ///
  void toast({
    String title = 'Mensaje',
    String message = 'Message content',
    int seconds = 3,
    ToastPosition position = ToastPosition.BOTTOM,
    Color color = Colors.transparent,
    double borderRadius = appMessageThemeRadius,
    bool buttonActive = false,
    String buttonLabel = 'OK',
    VoidCallback? onButtonPress,
    Widget? icon,
  }) {
    if (_isActiveLoading) {
      dismissLoading();
    }
    Get.snackbar(
      title,
      message,
      icon: icon,
      leftBarIndicatorColor: color,
      colorText: Colors.white,
      backgroundColor: appMessageThemeColor,
      borderRadius: borderRadius,
      shouldIconPulse: true,
      duration: Duration(seconds: seconds),
      snackPosition: position == ToastPosition.TOP
          ? SnackPosition.TOP
          : SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      mainButton: buttonActive
          ? TextButton(
              onPressed: () {
                Get.back();
                onButtonPress?.call();
              },
              child: Text(
                buttonLabel,
                style: const TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }

  void snackbar({
    String title = 'Message',
    String message = 'Message content',
    int seconds = 3,
    ToastPosition position = ToastPosition.TOP,
    Color color = Colors.transparent,
    double borderRadius = appMessageThemeRadius,
    bool buttonActive = false,
    String buttonLabel = 'OK',
    VoidCallback? onButtonPress,
    Widget? icon,
  }) {
    if (_isActiveLoading) {
      dismissLoading();
    }
    // Get.rawSnackbar(
    //   title: title,
    //   message: message,
    //   margin: EdgeInsets.all(10),
    //   padding: EdgeInsets.all(25),
    // );
  }

  /// Cuadro de diálogo [ALERT] que simula un mensaje de
  /// alerta del sistema. Ejemplo:
  ///
  /// ```dart
  /// AppMessage.service.alert(
  ///   title: 'Advertencia',
  ///   message: 'Bateria al 10% de su capacidad. Bateria muy baja.',
  ///   borderRadius: 10.0,
  ///   buttonLabel: 'Entendido',
  ///   onButtonPress: () {},
  /// );
  /// ```
  ///
  Future<bool>? alert({
    String title = 'Alert',
    String message = 'Alert content',
    String buttonLabel = 'OK',
    VoidCallback? onButtonPress,
    double borderRadius = appMessageThemeRadius,
  }) async {
    if (_isActiveLoading) {
      dismissLoading();
    }
    return await Get.defaultDialog(
          title: title,
          titlePadding: const EdgeInsets.symmetric(vertical: 20.0),
          titleStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          content: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              message,
              textAlign: TextAlign.center,
              // style: AppStyles.textStyle16Bold,
            ),
          ),
          radius: borderRadius,
          barrierDismissible: true,
          actions: [
            // ButtonAppComponent(
            //   text: buttonLabel,
            //   height: 40.0,
            //   onPress: () {
            //     Get.back();
            //     onButtonPress?.call();
            //   },
            // )
          ],
        ) ??
        false;
  }

  /// Cuadro de diálogo [CONFIRM] que simula un mensaje de
  /// confirmación del sistema. Ejemplo:
  ///
  /// ```dart
  /// AppMessage.service.confirm(
  ///   title: 'Confirmación',
  ///   message: '¿Estás seguro de que quieres cerrar esta aplicación?',
  ///   borderRadius: 10.0,
  ///   confirmLabel: 'Si',
  ///   cancelLabel: 'No',
  ///   onConfirm: () => exit(0),
  ///   onCancel: () {},
  /// )
  /// ```
  ///
  Future<bool> confirm({
    String title = 'Confirm',
    String message = 'Confirm content',
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    double borderRadius = appMessageThemeRadius,
  }) async {
    if (_isActiveLoading) {
      dismissLoading();
    }
    return await Get.defaultDialog(
          titlePadding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          title: title,
          titleStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: AppColors.primary, fontSize: 16.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CupertinoButton(
                      child: Container(
                        height: 45.0,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          cancelLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        onCancel?.call();
                      },
                    ),
                  ),
                  Expanded(
                    child: CupertinoButton(
                      child: Container(
                        height: 45.0,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          confirmLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        onConfirm?.call();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
          radius: borderRadius,
          barrierDismissible: false,
        ) ??
        false;
  }

  /// Cuadro de diálogo [PROMPT] que simula un mensaje
  /// del sistema. Ejemplo:
  ///
  /// ```dart
  /// AppMessage.service.prompt(
  ///   title: 'Código de seguridad',
  ///   message: 'Entre el código de seguridad',
  ///   borderRadius: 10.0,
  ///   confirmLabel: 'OK',
  ///   cancelLabel: 'Cancelar',
  ///   onConfirm: (value) {
  ///     print(value);
  ///   },
  ///   onCancel: () {},
  /// )
  /// ```
  ///
  Future<String> prompt({
    String title = 'Prompt',
    String message = 'In your data',
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
    PromptTypeData<String>? onConfirm,
    VoidCallback? onCancel,
    double borderRadius = appMessageThemeRadius,
  }) async {
    if (_isActiveLoading) {
      dismissLoading();
    }
    return await Get.defaultDialog(
          title: title,
          titleStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          content: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Text(message, textAlign: TextAlign.center),
                Obx(
                  () => Form(
                    key: _formPromptKey,
                    autovalidateMode: _formPromptAutovalidate.value
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (GetUtils.isNullOrBlank(value)!) {
                          return 'The field is required'.tr;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String value) {
                        _formPromptValue = value;
                      },
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        errorMaxLines: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          radius: borderRadius,
          barrierDismissible: false,
          actions: [
            ElevatedButton(
              child: Text(confirmLabel),
              onPressed: () {
                if (_formPromptKey.currentState!.validate()) {
                  Get.back();
                  onConfirm?.call(_formPromptValue);
                }
                _formPromptAutovalidate.value = true;
              },
            ),
            ElevatedButton(
              child: Text(cancelLabel),
              onPressed: () {
                Get.back();
                onCancel?.call();
              },
            ),
          ],
        ) ??
        false;
  }

  /// Cuadro de diálogo [ACTION SHEET] que simula un
  /// menu de opciones en la parte inferior del
  /// sistema. Ejemplo:
  ///
  /// ```dart
  /// List<Widget> list = <Widget>[
  ///   ActionSheetElement(
  ///     icon: Icon(Icons.share),
  ///     text: 'Share',
  ///     type: ActionSheetElementType.ROW,
  ///     onPress: () {},
  ///   ),
  ///   ActionSheetElement(
  ///     icon: Icon(Icons.camera),
  ///     text: 'Camera',
  ///     type: ActionSheetElementType.ROW,
  ///   ),
  ///   ActionSheetElement(
  ///     icon: Icon(Icons.watch),
  ///     text: 'Watch',
  ///     onPress: () {},
  ///     type: ActionSheetElementType.ROW,
  ///   ),
  /// ];
  ///
  /// AppMessage.service.actionSheet(
  ///   title: 'Albums',
  ///   elements: list,
  ///   height: 100,
  /// );
  ///
  /// ```
  ///
  actionSheet(
      {required String title,
      required double height,
      required List<Widget> elements,
      List<Widget> actions = const [],
      bool enableDrag = true,
      bool isDismissible = true,
      bool isArrow = false}) {
    if (_isActiveLoading) {
      dismissLoading();
    }
    return Get.bottomSheet(
      Wrap(
        children: [
          HeaderActionSheet(
            title: title,
            isArrow: isArrow,
            actions: actions,
          ),
          ListActionSheet(
            contentHeight: height,
            children: elements,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      isDismissible: isDismissible,
      isScrollControlled: true,
      enableDrag: enableDrag,
    );
  }
  // ...

  /// Cuadro de diálogo que permite mostrar una vista personalizada
  ///  Ejemplo:
  ///
  /// ```dart
  /// AppMessage.service.customDialog(
  ///   backgroundColor: Colors.white,
  ///   widget: Container(),
  ///   barrierDismissible: true,
  /// )
  /// ```
  ///
  Future<dynamic> customDialog(
      {Color backgroundColor = Colors.transparent,
      Widget? widget,
      barrierDismissible = false}) async {
    if (_isActiveLoading) {
      dismissLoading();
    }
    return await Get.dialog(
      WillPopScope(
          onWillPop: () async {
            if (barrierDismissible) {
              return true;
            } else {
              return false;
            }
          },
          child: Material(color: backgroundColor, child: widget)),
      barrierDismissible: barrierDismissible,
    );
  }

  // ...

  bool _isActiveLoading = false;
  bool get isActiveLoading => _isActiveLoading;

  void dismissLoading() {
    if (_isActiveLoading) {
      _isActiveLoading = false;
      Get.back();
    }
  }

  void presentLoading({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    if (!_isActiveLoading) {
      _isActiveLoading = true;
      Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(false),
          child: Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: AppColors.primary,
              size: 40,
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  // ...
}

class HeaderActionSheet extends StatelessWidget {
  const HeaderActionSheet({
    super.key,
    required this.title,
    this.isArrow = false,
    this.actions = const <Widget>[],
  });

  final String title;
  final bool isArrow;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            isArrow
                ? const Positioned(
                    top: -45.0,
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 80.0,
                      color: AppColors.primary,
                    ))
                : Container(),
            Column(
              children: [
                Container(
                  width: 100.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(50.0)),
                  margin: const EdgeInsets.only(top: 20.0),
                ),
                ListTile(
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            actions.isNotEmpty
                ? Positioned(
                    right: 20.0,
                    child: Wrap(
                      spacing: 12, // space between two icons
                      children: actions,
                    ),
                  )
                : const SizedBox.shrink(),
          ]),
    );
  }
}

class ListActionSheet extends StatelessWidget {
  const ListActionSheet({
    super.key,
    this.contentHeight,
    this.children,
  });

  final double? contentHeight;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: contentHeight,
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: children!,
        ),
      ),
    );
  }
}

class ActionSheetColsElement extends StatelessWidget {
  const ActionSheetColsElement({
    super.key,
    this.icon,
    this.text,
    this.onPress,
  });

  final Widget? icon;
  final Text? text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[icon!],
      ),
      title: text,
      onTap: () {
        Get.back();
        onPress?.call();
      },
    );
  }
}

class ActionSheetRowsElement extends StatelessWidget {
  const ActionSheetRowsElement({
    super.key,
    this.icon,
    this.text,
    this.onPress,
  });

  final Widget? icon;
  final Text? text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Column(
          children: [
            icon!,
            const SizedBox(height: 5),
            text!,
          ],
        ),
        onPressed: () {
          Get.back();
          onPress?.call();
        },
      ),
    );
  }
}

class ActionSheetElement extends StatelessWidget {
  /// Elemento del componente [ACTION SHEET] que se ajustará
  /// y renderizará acorde al tipo de elemento descrito por
  /// su propiedad [TYPE]. Ejemplo:
  ///
  /// ```dart
  /// ActionSheetElement(
  ///   icon: Icon(Icons.share),
  ///   text: 'Share',
  ///   type: ActionSheetElementType.ROW,
  ///   onPress: () {},
  /// ),
  /// ```
  const ActionSheetElement({
    super.key,
    required this.icon,
    required this.text,
    required this.type,
    this.onPress,
  });

  final Widget icon;
  final Text text;
  final VoidCallback? onPress;
  final ActionSheetElementType type;

  @override
  Widget build(BuildContext context) {
    return type != ActionSheetElementType.ROW
        ? ActionSheetColsElement(
            icon: icon,
            text: text,
            onPress: onPress,
          )
        : ActionSheetRowsElement(
            icon: icon,
            text: text,
            onPress: onPress,
          );
  }
}
