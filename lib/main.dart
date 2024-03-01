import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'src/app.dart';

import 'src/environment/environment.dart';
import 'src/services/system/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Bloquear la orientación del dispositivo
  // para solo vista en modo [Portrait]
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await AppStorage.service.init();

  // Crearemos los valores en el Storage Nativo
  // en caso de que aún no existan, de lo contrario
  // no se hace nada
  // ignore: deprecated_member_use
  String language = window.locale.languageCode;
  AppStorage.service.saveIfNull(Environment.language, language);
  AppStorage.service.saveIfNull(Environment.loginRememberAcount, false);
  AppStorage.service.saveIfNull(Environment.loginRememberEmail, '');
  AppStorage.service.saveIfNull(Environment.loginRememberPassword, '');
  AppStorage.service.saveIfNull(Environment.accessToken, '');
  AppStorage.service.saveIfNull(Environment.accessToken, '');

  runApp(DevicePreview(
      enabled: kDebugMode,
      builder: (context) => MyApp(
            language: language,
          )));
}
