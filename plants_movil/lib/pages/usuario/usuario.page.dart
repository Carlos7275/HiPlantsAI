import 'package:flutter/material.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/services/usuario.service.dart';

class UsuarioPage extends StatefulWidget {
  UsuarioPage({super.key});

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
          : Column(
              children: [
                const Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  "Hola ${usuario!.nombres}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
    );
  }
}
