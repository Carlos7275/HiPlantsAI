import 'package:flutter/material.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/routes.dart';

class PlantsWidget extends StatelessWidget {
  const PlantsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plants App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Enviroment.secondaryColor,
          primary: Enviroment.primaryColor,
          secondary: Enviroment.secondaryColor,
        ),
      ),
      initialRoute: "/",
      routes: routes,
    );
  }
}
