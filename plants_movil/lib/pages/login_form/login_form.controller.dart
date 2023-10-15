import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormController extends Controller {
  //Controladores de EdicionDeTexto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);



  String? emailValidator(String? text) {
    if (text != null && Regex.email.hasMatch(text)) {
      return null;
    } else {
      return 'Ingresa un email valido';
    }
  }

  String? passwordValidator(String? text) {
    if (text != null && text.length >= 3) {
      return null;
    } else {
      return 'Contraseña minima de 3 caracteres';
    }
  }

  login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);

      isLoading$.add(false);
    }
  }

  enviar(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);
      UsuarioService()
          .login(emailController.text, passwordController.text)
          .then((Map<String, dynamic> resp) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString("token", resp['data']); //Guardar Token
        isLoading$.add(false);
        /*AppStore().dispatch(
            Login(Administrador.fromJson(decodificado), resp['data']));
*/
        //    Modular.to.pushNamed('/home');
      }).catchError((error) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: jsonDecode(error.body)["message"],
          showConfirmBtn: true,
        );

        isLoading$.add(false);
      });
    }

    @override
    void dispose() {
      super.dispose();
      emailController.dispose();
      passwordController.dispose();

      isLoading$.close();
    }
  }
}
