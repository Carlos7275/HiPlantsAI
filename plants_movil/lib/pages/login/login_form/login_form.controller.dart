import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormController extends Controller {
  //Controladores de EdicionDeTexto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);

  enviar(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);

      UsuarioService()
          .login(emailController.text, passwordController.text)
          .then((Map<String, dynamic> resp) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var token = resp['data'];
        prefs.setString("token", token); //Guardar Token
        UsuarioService().me().then((Map<String, dynamic> resp) async {
          prefs.setString("info_usuario", jsonEncode(resp["data"]));
          isLoading$.add(false);
          Modular.to.pushNamed('home');
        }).catchError((error) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: jsonDecode(error.body)["message"],
            showConfirmBtn: true,
          );
        });
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
  }
}
