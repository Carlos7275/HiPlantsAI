import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Usuario? usuario;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    obtenerInfoUsuario();
  }

  void obtenerInfoUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UsuarioService().me().then((value) =>
        preferences.setString("info_usuario", jsonEncode(value["data"])));
    usuario = await UsuarioService().obtenerInfoUsuario();
    setState(() {
      if (usuario != null) isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Plants",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Enviroment.secondaryColor,
            shape: const RoundedRectangleBorder()),
        drawer: Drawer(
            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(), // Indicador de carga
                    )
                  : DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Enviroment.secondaryColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    Enviroment.server + usuario!.urlImagen!),
                              ),
                            ),
                          ),
                          Text(
                            "Hola ${usuario!.nombres!}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Email:${usuario!.email}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
              ListTile(
                leading: const Icon(Icons.data_usage),
                title: const Text('Recorridos'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.supervised_user_circle_outlined),
                title: const Text('Configuracion del Usuario'),
                onTap: () async {
                  Modular.to.pushNamed('/infousuario/', arguments: usuario);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuracion del Sistema'),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar Sesion'),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Modular.to.pushNamed('/');
                },
              ),
            ])));
  }
}
