import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rxdart/rxdart.dart';

class UsuarioFormController extends Controller {
  //Controladores de EdicionDeTexto
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);

  UsuarioFormController() {
    obtenerDatos();
  }
  void obtenerDatos() async {
    Usuario infousuario = await UsuarioService().obtenerInfoUsuario();
    controllers[0].text = infousuario.email!;
    controllers[1].text = infousuario.nombres!;
    controllers[2].text = infousuario.apellidoPaterno!;
    controllers[3].text = infousuario.apellidoMaterno!;
    controllers[4].text = infousuario.domicilio!;
  }

  enviar(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);

      isLoading$.add(false);
    }
  }
}
