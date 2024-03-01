import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//...
import '../../environment/environment.dart';
import '../../global/global_controller.dart';
import '../../models/credencial_model.dart';
import '../../models/respuesta_peticion_model.dart';
import '../../routes/app_routes.dart';
import '../../services/message/app_message.dart';
import '../../services/providers/user_service.dart';
import '../../themes/colors_theme.dart';

class LoginController extends GetxController {
  // Instancia del controlador global
  GlobalController? ctrlGlobal;
  // Instancia para la manipulación del Storage Nativo
  final storage = GetStorage();
  // Observable para guardar en el storage nativo las
  // credenciales del usuario
  RxBool remember = false.obs;
  // Observable para mostrar u ocultar la contraseña
  RxBool obscure = true.obs;
  // Observable para realizar la auto-evaluación del
  // formulario
  RxBool autovalidate = false.obs;
  // Controladores del formulario para los diferentes
  // inputs de textos
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // key de formaulario login
  final formKey = GlobalKey<FormState>();

  RxBool showPass = true.obs;

  @override
  void onInit() {
    // Instancia del controlador global
    ctrlGlobal = Get.find<GlobalController>();
    super.onInit();
    // ...
    // Cada vez que se redibuje el widget es necesario
    // cargar las credenciales del usuario desde el
    // Storage Nativo
    loadRememberOption();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void buttonLoginPress(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    // Validar los campos del formulario de las
    // credenciales del usuario
    if (formKey.currentState!.validate()) {
      login();
      // toDashboard();
    }
    // A partir de la primera solicitud de autenticación
    // ya el formulario se auto-validará
    autovalidate.value = true;
  }

  Future<void> login() async {
    // Activo el loading
    AppMessage.service.presentLoading();
    // Solicito la autenticación del usuario con sus
    // credenciales al servidor

    // Creo el objeto con las credenciales
    final CredencialModel credencial = CredencialModel(
        username: email.text,
        password: password.text,
        remember: remember.value);
    // LLamo a la funcion que hace la peticion al servidor

    await UserService().login(credencialModel: credencial);
    final RespuestaPeticion<String> response =
        RespuestaPeticion<String>(status: true);

    if (response.status) {
      // Actualizo las preferencias del usuario en el
      // storage nativo
      updateRememberCredentials();
      resetForm();
      AppMessage.service.dismissLoading();
      Get.offNamed(AppPages.home.name);
    } else {
      AppMessage.service.toast(
          title: 'Alerta'.tr,
          seconds: 4,
          color: AppColors.errorColor!,
          message: response.results!,
          position: ToastPosition.BOTTOM);
      if (credencial.remember!) {
        password.clear();
        autovalidate.value = false;
        // formKey.currentState.reset();
      }
      // formKey.currentState.reset();
    }
  }

  // Función para resetear el formulario de login
  resetForm() {
    email.clear();
    password.clear();
    remember.value = false;
    autovalidate.value = false;
    // formKey.currentState.reset();
  }

  loadRememberOption() async {
    // Obtener los valores del Storage Nativo y
    // actualizar la vista
    bool state = storage.read(Environment.loginRememberAcount);
    remember.value = state;
    if (state) {
      showPass.value = false;
      email.text = storage.read(Environment.loginRememberEmail);
      password.text = storage.read(Environment.loginRememberPassword);
    } else {
      showPass.value = true;
      email.text = '';
      password.text = '';
    }
    obscure.value = true;
  }

  updateRememberCredentials() async {
    // Si esta activo el checkbox de guardar las credenciales
    // del usuario
    if (remember.value) {
      storage.write(Environment.loginRememberAcount, remember.value);
      storage.write(Environment.loginRememberEmail, email.text);
      storage.write(Environment.loginRememberPassword, password.text);
    } else {
      // Sino está activo el checkbox de guardar las
      // credenciales del usuario, actualizar los estados
      // de las credenciales en el storage nativo
      storage.write(Environment.loginRememberAcount, false);
      storage.write(Environment.loginRememberEmail, '');
      storage.write(Environment.loginRememberPassword, '');
    }
  }

  onForgotPass() async {
    // Ir a la interfaz del
    // registro de usuario
    final result = await Get.toNamed('/forgot');
    // Luego del retorno al login
    // si vienen los datos del registro
    if (result != null) {
      // Actualizar la interfaz
      email.text = result['email'];
    }
  }

  onRegister() async {
    // final result = await Get.toNamed(AppPages.register.name);
  }
}
