import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/models/Requests/Contra.model.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rxdart/rxdart.dart';

class CambiarContraController extends Controller {
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());

  enviar(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);
      ContrasModel contras = ContrasModel(
          passwordActual: controllers[0].text,
          passwordNueva: controllers[1].text,
          passwordAuxiliar: controllers[2].text);

      UsuarioService().cambiarContra(contras).then((value) {
        QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: "¡Operación Exitosa!",
                text: value["data"])
            .then((value) => {Modular.to.pushNamed("infousuario")});
      }).catchError((error) {
        isLoading$.add(false);

        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: jsonDecode(error.body)["message"],
          showConfirmBtn: true,
        );
      });
    }
  }

  String? verificarPassword(String? password) {
    if (password!.isEmpty) {
      return "Ingrese la Contraseña";
    } else if (password == controllers[1].text) {
      return null;
    } else {
      return "Las contraseñas no coinciden";
    }
  }
}
