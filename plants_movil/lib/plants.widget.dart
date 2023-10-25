import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/env/local.env.dart';

class PlantsWidget extends StatelessWidget {
  const PlantsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'App de Plantas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Enviroment.secondaryColor,
          primary: Enviroment.primaryColor,
          secondary: Enviroment.secondaryColor,
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
