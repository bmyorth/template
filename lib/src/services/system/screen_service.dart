import 'package:flutter/material.dart';

/// Servicio personalizado para obtener datos del área
/// habilitada (el contexto) del actual widget en uso.
class AppScreen {
  MediaQueryData? _mediaQueryData;

  /// Dimención del ancho permitido.
  double? width;

  /// Dimención de la altura permitida.
  double? height;

  /// Orientación del dispositivo. Esta propiedad es
  /// recomendable utilizarla en el contexto del
  /// scafold de la app.
  Orientation? orientation;

  AppScreen(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData!.size.width;
    height = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }

  /// Verificar si el dispositivo se encuentra en modo
  /// [PORTRAIT], Eso sucede cuando [width < height]
  bool portrait() => orientation == Orientation.portrait;

  // bool landscape() => !portrait();
  /// Verificar si el dispositivo se encuentra en modo
  /// [LANDSCAPE], Eso sucede cuando es no [PORTRAIT]
  bool landscape() => orientation == Orientation.landscape;

  /// Porciento que representa [persent] con respecto al
  /// ancho disponible.
  double widthPercent(double percent) {
    return width! * percent / 100;
  }

  /// Porciento que representa [persent] con respecto a la
  /// altura disponible.
  double heightPercent(double percent) {
    return height! * percent / 100;
  }
}
