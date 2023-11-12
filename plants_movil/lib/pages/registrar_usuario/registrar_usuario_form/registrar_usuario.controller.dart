import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/models/CodigosPostales.model.dart';
import 'package:plants_movil/models/Generos.model.dart';
import 'package:plants_movil/models/RegistrarUsuario.model.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rxdart/rxdart.dart';

class RegistrarUsuarioController extends Controller {
  List<TextEditingController> controllers =
      List.generate(9, (index) => TextEditingController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);

  //creamos la variable que nos trai los datos del modelo

  enviar(
    BuildContext context,
    Generos? genero,
    CodigosPostales? asentamiento,
  ) {
    if (formKey.currentState!.validate()) {
      // isLoading$.add(true);
      RegistrarUsuarioModel usuario = RegistrarUsuarioModel(
          email: controllers[0].text,
          password: controllers[1].text,
          nombres: controllers[2].text,
          apellidoPaterno: controllers[3].text,
          apellidoMaterno: controllers[4].text,
          domicilio: controllers[5].text,
          cp: controllers[6].text,
          fechaNacimiento: controllers[7].text,
          idGenero: genero!.idGenero,
          idAsentaCpcons: asentamiento!.idAsentaCpcons);

      UsuarioService().registrarUsuario(usuario).then((value) {
        QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: "¡Operación Exitosa!",
                text: value["data"])
            .then((value) => Modular.to.pushNamed('/'));
      }).catchError((error) {
        isLoading$.add(false);

        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: jsonDecode(error.body)["data"],
          showConfirmBtn: true,
        );
      });
    }
  }

  String? verificarPassword(String? password) {
    if (password!.isEmpty) {
      return "Ingrese la Contraseña";
    } else if (password == controllers[8].text) {
      return null;
    } else {
      return "Las contraseñas no coinciden";
    }
  }
}
