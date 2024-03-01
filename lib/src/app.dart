import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'global/global_controller.dart';
import 'routes/app_routes.dart';
import 'services/translation/app-internationalization.dart';
import 'themes/styles_theme.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  final String language;
  const MyApp({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    AppInternationalization.language = language;

    Get.put(GlobalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      onGenerateTitle: (BuildContext context) => 'Template',
      title: 'Template',
      // Estilo general en la app
      // theme: AppStyles.lightTheme,
      // darkTheme: AppStyles.darkTheme,
      // themeMode: ThemeMode.system,
      theme: AppStyles.lightTheme,
      darkTheme: AppStyles.darkTheme,
      themeMode: ThemeMode.system,

      // Internacionalización
      translations: AppInternationalization(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'US'), Locale('en', 'US')],
      locale: AppInternationalization.locale,

      initialRoute: AppPages.splashPage.name,

      getPages: AppPages.pages,
    );
  }
}
