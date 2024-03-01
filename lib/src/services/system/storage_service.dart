import 'package:get_storage/get_storage.dart';

/// Servicio personalizado para la gestión
/// de los datos en el storage del dispositivo
class AppStorage {
  AppStorage._internal();
  static final AppStorage _instance = AppStorage._internal();

  /// Patrón Singleton para el servicio de la barra de estado,
  /// proporcionando una única intancia del servicio.
  static AppStorage get service => _instance;

  // Instancia del Storage Nativo
  GetStorage? storage;

  /// Inicializar GetStorage para acceder a las apis de
  /// los dispositivos de almacenamiento
  Future<void> init() async {
    await GetStorage.init();
    storage = GetStorage();
  }

  /// Función que lee los datos del storage dado un key
  read(String key) async {
    return await storage!.read(key);
  }

  /// Función que guarda los datos del storage dado un key
  Future<void> save(String key, value) async {
    await storage!.write(key, value);
  }

  /// Función que guarda los datos del storage dado
  /// un key solo si es null
  Future<void> saveIfNull(String key, value) async {
    await storage!.writeIfNull(key, value);
  }

  Future<void> remove(String key) async {
    storage!.remove(key);
  }
}
