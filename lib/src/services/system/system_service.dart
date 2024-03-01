import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../global/widgets/button_app_widget.dart';
import '../../themes/colors_theme.dart';
import '../../types/app_types.dart';
import '../message/app_message.dart';

// ...

/// Estilos disponibles para la barra de estado superior.
enum StatusBarStyle { dart, light }

/// Servicio personalizado para manipular los estados de la barra de
/// estado superior, la de navegacion y más...
class AppSystem {
  AppSystem._internal();
  static final AppSystem _instance = AppSystem._internal();

  /// Patrón Singleton para el servicio de la barra de estado,
  /// proporcionando una única intancia del servicio.
  static AppSystem get service => _instance;

  // ...
  // STATUS BAR
  // ...

  /// Mostrar la barra de estado inferior [navBar].
  Future<void> statusBottomShow() async {
    return await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  /// Mostrar la barra de estado superior [statusBar].
  Future<void> statusBarTopShow() async {
    return await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  // ...
  // Ocultar las barra de estado del sistema. La
  // superior e inferior [statusBar]
  // ...
  Future<void> statusBarTopHiden() async {
    return await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  // ...
  // Ocultar las barra de estado del sistema. La
  // superior e inferior [statusBar & navBar]
  // ...
  Future<void> systemBarHiden() async {
    return await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
  }

  // ...
  // Mostrar las barra de estado del sistema. La
  // superior e inferior [statusBar & navBar]
  // ...
  Future<void> systemBarShow() async {
    return await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  /// Personalizar el color la barra de estado superior.
  void statusBarColor(Color color) {
    return SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
    ));
  }

  /// Personalizar el estilo predefinido de la barra de
  /// estado superior.
  void statusBarStyle(StatusBarStyle style) {
    return SystemChrome.setSystemUIOverlayStyle(
      style == StatusBarStyle.dart
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
    );
  }

  // ...
  // NAVIGATOR BAR
  // ...

  /// Personalizar el color la barra de navegación inferior.
  void navigationBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
    ));
  }

  // ...
  // THEME [STATUS BAR & NAVIGATOR BAR]
  // ...

  /// Tema personalizado para el sistema.
  SystemUiOverlayStyle appSystemTheme() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  ///  Devuelve la fecha en forma de string ej: 07/01/2022
  String getFecha({required DateTime value}) {
    return DateFormat('hh:mm a').format(value).toUpperCase();
  }

  /// Devuelve la hora en forma de string ej: 10:00 PM
  String getHora({required DateTime value}) {
    return DateFormat('hh:mm a').format(value).toUpperCase();
  }

  /// Une la fecha con la hora
  DateTime joinDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  /// verifica que la fecha y hora no sean antes del momento actual
  bool isBefore(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) return false;
    final selectedDate = joinDateTime(date, time);
    final now = DateTime.now();

    if (selectedDate.isBefore(now)) {
      return true;
    } else {
      return false;
    }
  }

  /// verifica si la fecha actual esta entre un rango
  bool isInsideRange({String? inicio, String? fin}) {
    DateTime startDate = DateTime.parse(inicio!);
    DateTime endDate = DateTime.parse(fin!);
    DateTime currentDate = DateTime.now();
    return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
  }

  /// Animar el scroll para que se mueva al cargar
  /// la nueva pagina
  void moveScroll({ScrollController? scrollController}) {
    scrollController!.animateTo(scrollController.position.pixels + 80,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 1500));
  }

  /// valida el rfc
  validatorRfc(String value) {
    String valid =
        '^(([A-Z]|[a-z]|s){1})(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))';
    if (value.length == 12) {
      valid = '^(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))';
    }
    final exp = RegExp(valid);
    return exp.hasMatch(value);
  }

  /// format 1,000.00
  String formatPrice({double? value}) {
    final formater = NumberFormat("#,##0.00", "en_US");
    return formater.format(value);
  }

  String formatKm({double? value}) {
    final formater = NumberFormat("#,##0.00", "en_US");
    return formater.format(value);
  }

  String formatSegundos({required int value}) {
    Duration duracion = Duration(seconds: value);
// Obtenemos las horas, los minutos y los segundos del objeto Duration
    int horas = duracion.inHours;
    int minutos = duracion.inMinutes.remainder(60);
    int segundos = duracion.inSeconds.remainder(60);
// Formateamos el tiempo como una cadena
    return "${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}";
  }

  Future<void> succesfullMessage({String? text}) async {
    await AppMessage.service.customDialog(
        widget: Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 40.0, bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Spin(
                    spins: 2,
                    delay: const Duration(milliseconds: 250),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: const Icon(
                        Icons.check_circle,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Success!'.tr,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black.withOpacity(0.03)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    child: Text(
                      text ?? '',
                      style: const TextStyle(
                        // color: Colors.green,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 40.0,
                  child: ButtonApp(
                    text: 'accept'.tr,
                    type: BUTTONTYPE.SECUNDARY,
                    onPress: () {
                      Get.back(result: true);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  /// Mostar mensaje de que no hay conexión
  mensajeSinConexion() {
    AppMessage.service.toast(
        title: 'information'.tr,
        icon: const Icon(Icons.info),
        seconds: 3,
        color: AppColors.errorColor!,
        message: 'not_connection'.tr,
        position: ToastPosition.BOTTOM);
  }

  /// Mostar mensaje de que no hay conexión
  mensajeErrorInesperado() {
    AppMessage.service.toast(
        title: 'information'.tr,
        icon: const Icon(Icons.info),
        seconds: 3,
        color: AppColors.errorColor!,
        message: 'try_again'.tr,
        position: ToastPosition.BOTTOM);
  }
}
