import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:rxdart/rxdart.dart';

class LoginFormController extends Controller {
  //Controladores de EdicionDeTexto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);

  // LoginFormController(this.usuarioService, this.store);

  String? emailValidator(String? text) {
    if (text != null && Regex.email.hasMatch(text)) {
      return null;
    } else {
      return 'Ingresa un email valido';
    }
  }

  String? passwordValidator(String? text) {
    if (text != null && text.length >= 8) {
      return null;
    } else {
      return 'Contraseña minima de 8 caracteres';
    }
  }

  login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);

      isLoading$.add(false);
    }
  }

  enviar() {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);
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
