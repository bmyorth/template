import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ...
import '../../environment/environment.dart';
import 'en.dart';
import 'es.dart';

/// Servicio para la traducción de la aplicación
/// completa a los diferentes idiomas permitidos.
class AppInternationalization extends Translations {
  /// Las configuraciones regionales admitidas.
  static final Map<String, Locale> locales = {
    'es': const Locale('es', 'CU'),
    'en': const Locale('en', 'US'),
  };

  /// Claves y sus traducciones respectivas, separadas
  /// en sus archivos correspondientes.
  @override
  Map<String, Map<String, String>> get keys => {
        'es': es,
        'en': en,
      };

  /// Configuración regional predeterminada.
  static String language = 'es';

  /// Configuración regional predeterminada.
  static final locale = locales[language];

  /// La configuración regional alternativa.
  static final fallbackLocale = locales['en'];

  /// Obtiene la configuración regional del idioma y
  /// enviado por parámetro y actualiza la configuración
  /// regional.
  void changeLocale(String language) {
    Locale? locale =
        (locales[language] != null) ? locales[language] : Get.locale;
    Get.updateLocale(locale!);
    // Cada vez que se cambie el idioma se registra en
    // el Storage Nativo
    final storage = GetStorage();
    storage.write(Environment.language, locale.languageCode);
  }

  static Locale? getlocale() =>
      (locales[language] != null) ? locales[language] : Get.locale;
}
