import 'package:flutter/material.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/pages/usuario/usuario_form/usuario_form.dart';
import 'package:plants_movil/services/usuario.service.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  Usuario? usuario;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    obtenerInfoUsuario();
  }

  void obtenerInfoUsuario() async {
    usuario = await UsuarioService().obtenerInfoUsuario();
    setState(() {
      if (usuario != null) isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Configuracion de Usuario",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Enviroment.secondaryColor,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Column(children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: UsuarioForm(
                    infoUsuario: usuario!,
                  ),
                )
              ])
            ]),
              )));
  }
}
