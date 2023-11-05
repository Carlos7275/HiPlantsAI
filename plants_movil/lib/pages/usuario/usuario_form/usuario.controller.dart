import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/models/CodigosPostales.model.dart';
import 'package:plants_movil/models/Generos.model.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioFormController extends Controller {
  //Controladores de EdicionDeTexto
  List<TextEditingController> controllers =
      List.generate(7, (index) => TextEditingController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);
  late Usuario infousuario;
  UsuarioFormController() {
    obtenerDatos();
  }

  void obtenerDatos() async {
    infousuario = await UsuarioService().obtenerInfoUsuario();
    controllers[0].text = infousuario.email!;
    controllers[1].text = infousuario.nombres!;
    controllers[2].text = infousuario.apellidoPaterno!;
    controllers[3].text = infousuario.apellidoMaterno!;
    controllers[4].text = infousuario.cp!;
    controllers[5].text = infousuario.domicilio!;
    controllers[6].text = infousuario.fechaNacimiento!;
  }

  enviar(BuildContext context, Generos? genero, CodigosPostales? asentamiento,
      String? imagen) {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);

      Usuario usuario = Usuario(
          email: controllers[0].text,
          nombres: controllers[1].text,
          apellidoPaterno: controllers[2].text,
          apellidoMaterno: controllers[3].text,
          cp: controllers[4].text,
          domicilio: controllers[5].text,
          fechaNacimiento: controllers[6].text,
          idAsentaCpcons: asentamiento!.idAsentaCpcons,
          idGenero: genero!.idGenero,
          idRol: infousuario.idRol,
          urlImagen: imagen);

      UsuarioService()
          .actualizarUsuario(infousuario.id!, usuario)
          .then((value) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "¡Operación Exitosa!",
            text: value["data"]);
      }).catchError((error) {
        isLoading$.add(false);

        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: jsonDecode(error.body)["message"],
          showConfirmBtn: true,
        );
      });
      UsuarioService().me().then((Map<String, dynamic> resp) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("info_usuario", jsonEncode(resp["data"]));
        isLoading$.add(false);
      });
    }
  }
}
