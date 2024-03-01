import 'dart:convert';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;
import 'package:latlong2/latlong.dart';

import '../../models/geo_address_model.dart';

/// Servicio para las obtener la localización del dispositivo.
class AppGeolacation extends GetConnect {
  AppGeolacation._internal();
  static final AppGeolacation _instance = AppGeolacation._internal();

  /// Patrón Singleton para el servicio de Firebase,
  /// proporcionando una única intancia del servicio.
  static AppGeolacation get service => _instance;

  bool serviceEnabled = false;
  LocationPermission? permission;

  // Check if there is permissions and if not request
  Future<bool> checkPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error('location_permissions_denied_permanently');
      await Geolocator.openAppSettings();
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position?> determinePosition() async {
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try {
        Position? position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        return position;
      } catch (e) {
        return null;
      }
    } else {
      return await getLastKnownPosition();
    }
  }

  Future<Position?> getLastKnownPosition() async {
    try {
      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      return null;
    }
  }

  /// Activar la localizacion
  Future<bool> activateLocation() async {
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      try {
        final result = await Geolocator.openLocationSettings();
        if (result) {
          return await Geolocator.isLocationServiceEnabled();
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    } else {
      return serviceEnabled;
    }
  }

  Future<LocationSettings> config() async {
    late LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        // intervalDuration: const Duration(seconds: 10),
        // //(Optional) Set foreground notification config to keep the app alive
        // //when going to the background
        // foregroundNotificationConfig: const ForegroundNotificationConfig(
        //   notificationText:
        //       "Example app will continue to receive your location even when you aren't using it",
        //   notificationTitle: "Running in Background",
        //   enableWakeLock: true,
        // ),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
    return locationSettings;
  }

  Future<GeoAddressModel> getAddressFromPosition(LatLng? position) async {
    String local = '';
    if (position != null) {
      local = 'lat=${position.latitude}&lon=${position.longitude}';
    }
    GeoAddressModel geo = GeoAddressModel();

    String url = 'https://photon.komoot.io/reverse?$local';
    try {
      final resp = await get(url);
      final Map<String, dynamic> decodedData =
          json.decode(utf8.decode(resp.body));
      final List<dynamic> predictions = decodedData["features"] ?? [];

      if (predictions.isNotEmpty) {
        geo = GeoAddressModel.fromPhotonAPI(predictions.first);
      }
    } catch (e) {
      return geo;
    }

    return geo;
  }

  Future<List<GeoAddressModel>> loadDireccion(
      {required String query, LatLng? position}) async {
    String local = '';
    if (position != null) {
      local = '&lat=${position.latitude}&lon=${position.longitude}';
    }
    List<GeoAddressModel> list = <GeoAddressModel>[];
    if (query.isNotEmpty) {
      String url =
          'https://photon.komoot.io/api/?q=$query&limit=10$local&lang=en';
      try {
        final resp = await get(url);
        final Map<String, dynamic> decodedData =
            json.decode(utf8.decode(resp.body));
        final List<dynamic> predictions = decodedData["features"] ?? [];

        if (predictions.isNotEmpty) {
          for (var value in predictions) {
            GeoAddressModel geo = GeoAddressModel.fromPhotonAPI(value);
            if (geo.placemark!.country!.toLowerCase().contains('cuba')) {
              list.add(geo);
            }
          }
        }
      } catch (e) {
        return list;
      }
    }

    return list;
  }

  // Future<List<GeoAddressModel>> addressSugerencia(String searchText,
  //     {int limitInformation = 5, Position? pos}) async {
  //   final response = await Dio.Dio().get(
  //     "https://photon.komoot.io/api/",
  //     queryParameters: {
  //       "q": searchText,
  //       "limit": limitInformation == 0 ? "" : "$limitInformation",
  //       "lat": pos != null ? pos.lat : "",
  //       "lon": pos != null ? pos.lng : "",
  //     },
  //   );
  //   final json = response.data;

  //   return (json["features"] as List)
  //       .map((d) => SearchInfo.fromPhotonAPI(d))
  //       .toList();
  // }

  // Future<List<SearchInfo>> reverve(LngLat pos) async {
  //   final response = await Dio.Dio().get(
  //     "https://photon.komoot.io/reverse",
  //     queryParameters: {
  //       "lat": pos.lat,
  //       "lon": pos.lng,
  //     },
  //   );
  //   final json = response.data;
  //   print(json);

  //   return (json["features"] as List)
  //       .map((d) => SearchInfo.fromPhotonAPI(d))
  //       .toList();
  // }
}
