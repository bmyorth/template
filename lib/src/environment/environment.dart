/// Servicio personalizado para obtener recursos
/// estáticos de la app.
class Environment {
  Environment._internal();
  static final Environment _instance = Environment._internal();

  /// Patrón Singleton para el servicio de la camara,
  /// proporcionando una única intancia del servicio.
  static Environment get service => _instance;

  //
  static String urlServices = 'https://xxx.com';
  static String urlSocket = 'wss://xxx.com/application/connected';

  // MAP
  static String urlTemplateMap = 'https://xxx.com/tile/{z}/{x}/{y}.png';
  static String appPackageName = 'com.idoogroup.app.template';

  // ...
  static const language = 'app-template-language';
  static const overview = 'app-template-overview';
  static const loginRememberAcount = 'app-template-remember-acount';
  static const loginRememberEmail = 'app-template-remember-email';
  static const loginRememberPassword = 'app-template-remember-password';
  static const accessToken = 'app-template-access-token';

  static String apiKeyGoogle = 'AIzaSyB4YLGYn7FZbag9FkVdM_xSYY9KhXNlK10';
}
