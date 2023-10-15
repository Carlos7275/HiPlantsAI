import 'package:flutter/material.dart';
import 'package:plants_movil/pages/home/home.page.dart';
import 'package:plants_movil/pages/login/login.page.dart';

class RouteFunction {
  String url;
  Widget Function(BuildContext, dynamic) function;
  List<RouteFunction> children;
  RouteFunction(this.url, this.function, [this.children = const []]);
}

List<RouteFunction> myRoutes = [
  RouteFunction('/', (context, args) => const LoginPage()),
  RouteFunction('/home', (context, args) => const HomePage()),
];
