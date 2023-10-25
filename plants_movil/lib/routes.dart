import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/guards/islogin.guard.dart';
import 'package:plants_movil/pages/home/home.page.dart';
import 'package:plants_movil/pages/login/login.page.dart';
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
  RouteFunction('/', (context, args) => const LoginPage(), []),
  RouteFunction('/home', (context, args) => const HomePage(), [IsLoginGuard()]),
  RouteFunction(
      '/infousuario/', (context, args) => const UsuarioPage(), [IsLoginGuard()]),
];
