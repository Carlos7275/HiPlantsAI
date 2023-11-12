import 'package:flutter/material.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/pages/registrar_usuario/registrar_usuario_form/registrar_usuario_form.dart';

class RegistrarUsuarioPage extends StatefulWidget {
  const RegistrarUsuarioPage({super.key});

  @override
  State<RegistrarUsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<RegistrarUsuarioPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Registrarse",
            style: TextStyle(color: Colors.white),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          titleSpacing:
              20, // Espaciado entre el ícono/botón de retroceso y el texto del título
          centerTitle: false, // Alinea el texto del título a la izquierda
          backgroundColor: Enviroment.secondaryColor,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: const RegistrarUsuarioForm(),
              )
            ])
          ]),
        )));
  }
}
