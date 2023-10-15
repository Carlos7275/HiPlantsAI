import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/generics/redux/app.state.dart';
import 'package:plants_movil/generics/redux/app.store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppState state = AppStore().state;

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
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.

            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 227, 229),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Bienvenido ${state.user!.nombres}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                            image: NetworkImage(
                                Enviroment.server + state.user!.urlImagen!),
                            width: 60),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Email:${state.user!.email}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text('Mapa'),
                onTap: () {
                  Navigator.pop(context);
                },
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

                  Navigator.pop(context);
                },
              ),
            ])));
  }
}
