import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/guards/islogin.guard.dart';
import 'package:plants_movil/guards/isnotlogin.guard.dart';
import 'package:plants_movil/pages/cambiar_contra/cambiar_contra.page.dart';
import 'package:plants_movil/pages/home/home.page.dart';
import 'package:plants_movil/pages/login/login.page.dart';
import 'package:plants_movil/pages/recorridos/recorridos.page.dart';
import 'package:plants_movil/pages/registrar_plantas/registro_plantas.page.dart';
import 'package:plants_movil/pages/registrar_usuario/registrar_usuario.page.dart';
import 'package:plants_movil/pages/usuario/usuario.page.dart';

class RouteFunction {
  String url;
  Widget Function(BuildContext, dynamic) function;
  List<RouteFunction> children;
  List<RouteGuard> guards;

  RouteFunction(this.url, this.function, this.guards,
      [this.children = const []]);
}

List<RouteFunction> myRoutes = [
  RouteFunction('/', (context, args) => const LoginPage(), [IsNotLoginGuard()]),
  RouteFunction('/home', (context, args) => const HomePage(), [IsLoginGuard()]),
  RouteFunction('/infousuario/', (context, args) => const UsuarioPage(),
      [IsLoginGuard()]),
  RouteFunction(
      '/registrar', (context, args) => const RegistrarUsuarioPage(), []),
  RouteFunction(
    '/cambiarcontra',
    (context, args) => const CambiarContraPage(),
    [IsLoginGuard()],
  ),
  RouteFunction(
    '/registrarplanta',
    (context, args) => const RegistrarPlantasPage(),
    [IsLoginGuard()],
  ),
   RouteFunction(
    '/recorridos/',
    (context, args) => const RecorridosPage(),
    [IsLoginGuard()],
  )
];
