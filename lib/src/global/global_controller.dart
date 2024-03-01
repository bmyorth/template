import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/appversion_model.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';

//..

class GlobalController extends GetxController {
  // id del dispositivo
  String deviceId = '';

  // token firebase
  String token = '';

  //version de la app
  Rx<AppVersionModel> localVersion = AppVersionModel().obs;
  //version de la web
  Rx<AppVersionModel> onlineVersion = AppVersionModel().obs;

  final Rx<RxStatus> connectionStatus = RxStatus.empty().obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  // Listado de
  final RxList<NotificationModel> _notifications = <NotificationModel>[].obs;
  List<NotificationModel> get notifications => _notifications;
  set notifications(value) => _notifications.value = value;

  // Variables que indican que esta cargando
  RxBool loadingNotification = false.obs;

  // Total de notificaciones sin ver
  RxInt totalNotifications = 10.obs;

  /// Datos del usuario autenticado en el sistema
  Rx<UserModel> userAuth = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    // await NotificacionService.service.appFirebaseInit(this);

    await getIdDevice();
    // checkConnection();
    if (connectionStatus.value.isEmpty) {
      checkConnection();
    }
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  set user(UserModel value) {
    userAuth.value = value;
  }

  UserModel get session {
    if (GetUtils.isNullOrBlank(userAuth.value)!) {
      Get.offNamed(AppPages.login.name);
    }
    return userAuth.value;
  }

  Future<AppVersionModel> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionNumber = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    localVersion.value =
        AppVersionModel(version: versionNumber, build: int.parse(buildNumber));
    return localVersion.value;
  }

  Future<void> getIdDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor!;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
    }
    debugPrint('DEVICE ID: $deviceId');
    registerToken();
    loadNotificion();
  }

  void registerToken() async {
    // token = await NotificacionService.service.tokenDevice();
    // await CasinoService.service.registerToken(deviceId: deviceId, token: token);
    // await getCliente();
  }

  /// Carga todas las notificaciones
  Future<void> loadNotificion() async {
    // totalNotifications.value = 0;
    // notifications = await CasinoService.service.loadNotification(deviceId);
    // totalNotifications.value = notifications.results.length;
  }

  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      connectionStatus.value = RxStatus.error();
    } else {
      connectionStatus.value = RxStatus.loading();
      try {
        final response = await InternetAddress.lookup('google.com');
        if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
          connectionStatus.value = RxStatus.success();
        }
      } on SocketException catch (_) {
        connectionStatus.value = RxStatus.error();
      }
    }
    update();
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    await checkConnection();
  }
}
