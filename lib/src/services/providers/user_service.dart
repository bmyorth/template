import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../global/global_controller.dart';
import '../../models/change_pass_model.dart';
import '../../models/credencial_model.dart';
import '../../models/respuesta_peticion_model.dart';
import '../../models/user_model.dart';
import '../system/storage_service.dart';

//....

class UserService extends GetConnect {
  String urlServer = Environment.urlServices;

  // Instancia del controlador global
  GlobalController? ctrlGlobal;

  UserService() {
    // Instancia del controlador global
    ctrlGlobal = Get.find<GlobalController>();
  }

  // Cabecera en formato json usada para realizar las peticiones
  headers() {
    return <String, String>{"Authorization": "Token ${ctrlGlobal!.token}"};
  }

  // Cabecera en formato json usada para realizar las peticiones
  headersJson() {
    return <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Token ${ctrlGlobal!.token}"
    };
  }

  //Funcion que realiza la petición de auteticación al backend
  Future<RespuestaPeticion<String>> login({
    CredencialModel? credencialModel,
  }) async {
    ctrlGlobal!.user = UserModel(
        id: 1,
        username: "bmyorth",
        email: "bmyorth@gmail.com",
        ci: '00022927864',
        name: "Brian Pérez Castro",
        phone: "53594824",
        address: "Santa María, Guantanamo, Guantanamo, Cuba",
        urlPicture: "assets/images/mock-profile.jpg",
        isLocal: true);
    return RespuestaPeticion(status: true);
    // final sendBody = json.encode(credencialModel!.toJson());
    // // try {
    // final response = await post(
    //   '$urlServer/auth/token/login/',
    //   sendBody,
    //   headers: {"Content-Type": "application/json"},
    // );

    // if (response.statusCode != 200 &&
    //     response.statusCode != 201 &&
    //     response.statusCode != 400) {
    //   return RespuestaPeticion(
    //       status: false,
    //       results: 'An unexpected error occurred, please try again'.tr);
    // }

    // final Map<String, dynamic>? decodedData =
    //     json.decode(utf8.decode(response.body));

    //   if (decodedData == null) {
    //     return RespuestaPeticion(
    //         status: false,
    //         results: 'An unexpected error occurred, please try again'.tr);
    //   }

    //   if (GetUtils.isNullOrBlank(decodedData['auth_token'])!) {
    //     return RespuestaPeticion(
    //         status: false, results: 'Invalid credentials'.tr);
    //   }

    //   UserModel? user = await getUserByToken(token: decodedData['auth_token']);

    //   if (user == null) {
    //     return RespuestaPeticion(
    //         status: false,
    //         results: 'An unexpected error occurred, please try again'.tr);
    //   }

    //   ctrlGlobal!.user = user;
    //   WebSocketService.service.init();
    //   getLastSession();

    //   return RespuestaPeticion(status: true);
    // } on Exception catch (exception) {
    //   return RespuestaPeticion(status: false, results: exception.toString());
    // } catch (e) {
    //   RespuestaPeticion(
    //       status: false, results: 'Could not connect to server'.tr);
    // }
    // return RespuestaPeticion(
    //     status: false,
    //     results: 'An unexpected error occurred, please try again'.tr);
  }

  Future<bool> logout() async {
    try {
      final response = await http
          .post(Uri.parse('$urlServer/auth/token/logout'), headers: headers());

      if (response.statusCode != 200 &&
          response.statusCode != 201 &&
          response.statusCode != 204) {
        return false;
      }
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }

    return true;
  }

  //Funcion que realiza la petición para obtener los datos
  //del usuario autenticado al backend dado el token
  Future<UserModel?> getUserByToken({String? token}) async {
    return UserModel();
    // ctrlGlobal!.userToken = token!;
    // GraphqlService.service.init(token: token);

    // final QueryOptions options = QueryOptions(
    //   document: gql(UserGraphql.queryGetUserByToken),
    //   variables: <String, dynamic>{
    //     'jwt': token,
    //   },
    //   fetchPolicy: FetchPolicy.networkOnly,
    //   // errorPolicy: ErrorPolicy.ignore,
    // );

    // final QueryResult result =
    //     await GraphqlService.service.client!.query(options);

    // if (result.hasException) {
    //   if (result.exception!.linkException is NetworkException) {
    //     AppSystem.service.mensajeSinConexion();
    //   } else {
    //     ctrlGlobal?.removeSession();
    //     AppSystem.service.mensajeErrorInesperado();
    //   }
    //   return null;
    // }

    // try {
    //   Map<String, dynamic> response = result.data!['userInfo'];
    //   UserModel userModel = UserModel.fromJson(response);

    //   return userModel;
    // } on Exception catch (exception) {
    //   print(exception);
    //   return null;
    // } catch (e) {
    //   return null;
    // }
  }

  /// Función que permite verificar si el token esta vigente
  /// y por ende que el usuario aun sigue logeado
  Future<bool> verificaSession() async {
    String token = await AppStorage.service.read(Environment.accessToken);
    if (GetUtils.isNullOrBlank(token)!) {
      return false;
    } else {
      UserModel? user = await UserService().getUserByToken(token: token);

      if (GetUtils.isNull(user)) {
        return false;
      } else {
        // ctrlGlobal!.user = user!;
        // ctrlGlobal!.userToken = token;
        // WebSocketService.service.init();
        // getLastSession();
        return true;
      }
    }
  }

  /// Función que permite actualizar los puntos del usuario
  Future<bool> updateProfilePoints({int? id, int? point}) async {
    try {
      final url = Uri.parse('$urlServer/api/userupdate/');

      final imageUploadRequest = http.MultipartRequest('POST', url)
        ..headers.addAll(headers());

      Map<String, String> requestBody = {
        "user_id": id.toString(),
        "used_points": point.toString()
      };
      imageUploadRequest.fields.addAll(requestBody);

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);

      if (resp.statusCode != 200) {
        return false;
      }

      return true;
    } on Exception {
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Función que hace la petición para  cambiar la contraseña
  // Adicionar cliente
  Future<RespuestaPeticion<String>> changePass({ChangePassModel? model}) async {
    return RespuestaPeticion(status: true, results: 'ok'.tr);
    // try {
    //   final MutationOptions options = MutationOptions(
    //     document: gql(UserGraphql.mutationChangePasswword),
    //     variables: <String, dynamic>{
    //       'user': {
    //         'id': AppSystem.service
    //             .convertIdToBase64(model?.userId.toString() ?? ''),
    //         'password': model?.newPwd,
    //       }
    //     },
    //     fetchPolicy: FetchPolicy.networkOnly,
    //   );

    //   final QueryResult result =
    //       await GraphqlService.service.client!.mutate(options);

    //   if (result.hasException) {
    //     return RespuestaPeticion(
    //         status: false,
    //         results: 'An unexpected error occurred, please try again'.tr);
    //   }
    //   bool response = result.data!['changePassword']['info'] ?? false;
    //   if (!response) {
    //     return RespuestaPeticion(
    //         status: false,
    //         results: 'An unexpected error occurred, please try again'.tr);
    //   }

    //   return RespuestaPeticion(
    //       status: true, results: 'The password has been changed'.tr);
    // } on Exception catch (exception) {
    //   print(exception);
    //   return RespuestaPeticion(
    //       status: false, results: 'Could not connect to server'.tr);
    // } catch (e) {
    //   print(e);
    //   return RespuestaPeticion(
    //       status: false, results: 'Could not connect to server'.tr);
    // }
  }

  void getLastSession() async {
    await http.get(Uri.parse('$urlServer/api/lastloginupdate/'),
        headers: headers());
    debugPrint('last login update');
  }

  // //Funcion que realiza la petición para obtener los datos
  // //de las notificaciones de un cliente
  // Future<RespuestaList<NotificationModel>> loadNotificaciones(
  //     {int first = 10,
  //     String after = "",
  //     String? criteria,
  //     String? username,
  //     bool? read}) async {
  //   RespuestaList<NotificationModel> list = RespuestaList<NotificationModel>();
  //   try {
  //     final QueryOptions options = QueryOptions(
  //       document: gql(UserGraphql.queryLoadNotifications),
  //       variables: <String, dynamic>{
  //         'first': first,
  //         'after': after,
  //         'username': username,
  //         'read': read,
  //       },
  //       fetchPolicy: FetchPolicy.networkOnly,
  //     );

  //     final QueryResult result =
  //         await GraphqlService.service.client!.query(options);

  //     if (result.hasException) {
  //       if (result.exception!.linkException is NetworkException) {
  //         AppSystem.service.mensajeSinConexion();
  //       } else {
  //         AppSystem.service.mensajeErrorInesperado();
  //       }
  //       return list;
  //     }

  //     list = RespuestaList<NotificationModel>.fromJson(
  //         result.data!['searchNotification']);

  //     return list;
  //   } catch (e) {
  //     // AppSystem.service.mensajeErrorInesperado();
  //     return list;
  //   }
  // }

  // // marcar notificación como leida
  // Future<bool> checkRead({String? id}) async {
  //   try {
  //     final MutationOptions options = MutationOptions(
  //       document: gql(UserGraphql.mutationCheckRead),
  //       variables: <String, dynamic>{
  //         'id': id,
  //       },
  //       fetchPolicy: FetchPolicy.networkOnly,
  //     );

  //     final QueryResult result =
  //         await GraphqlService.service.client!.mutate(options);

  //     if (result.hasException) {
  //       if (result.exception!.linkException is NetworkException) {
  //         AppSystem.service.mensajeSinConexion();
  //       } else {
  //         AppSystem.service.mensajeErrorInesperado();
  //       }
  //       return false;
  //     }

  //     bool response =
  //         result.data!['readNotification']['error'] == null ? true : false;
  //     if (!response) {
  //       AppSystem.service.mensajeDatosNoUpdated();
  //       return false;
  //     }

  //     return true;
  //   } catch (e) {
  //     AppSystem.service.mensajeErrorInesperado();
  //     return false;
  //   }
  // }

  //Funcion actualiza el token device
  Future<void> updateTokenDevice({String? type, String? token}) async {
    // final MutationOptions options = MutationOptions(
    //   document: gql(UserGraphql.updatepdateTokenDevice),
    //   variables: <String, dynamic>{
    //     'obj': {
    //       'registrationId': token,
    //       'typeDevice': type,
    //     }
    //   },
    //   fetchPolicy: FetchPolicy.cacheAndNetwork,
    //   // errorPolicy: ErrorPolicy.ignore,
    // );

    // final QueryResult result =
    //     await GraphqlService.service.client!.mutate(options);

    // if (result.hasException) {
    //   if (result.exception!.linkException is NetworkException) {
    //     AppSystem.service.mensajeSinConexion();
    //   }
    // }
  }
}
