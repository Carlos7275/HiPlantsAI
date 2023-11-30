import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/pages/maps/maps.page.dart';
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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerInfoUsuario();
  }

  void obtenerInfoUsuario() async {
    usuario = await UsuarioService().obtenerInfoUsuario();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ModalRoute.of(context)!.settings.arguments != null) {
      setState(() {
        obtenerInfoUsuario();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Hi Plants AI",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Enviroment.secondaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ))),
        body: const MapsPage(),
        drawer: Drawer(
            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
              isLoading
                  ? const CircularProgressIndicator()
                  : DrawerHeader(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/drawer.jpg"),
                              fit: BoxFit.cover)),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                Enviroment.server + usuario!.urlImagen!),
                          ),
                          Text(
                            "${usuario!.nombres!} ${usuario!.apellidoPaterno} ${usuario!.apellidoMaterno}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "${usuario!.email}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                title: const Text('Configuración del Usuario'),
                onTap: () async {
                  Modular.to.pushNamed('/infousuario/');

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuración del Sistema'),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar Sesión'),
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
