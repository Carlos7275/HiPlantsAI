import 'package:flutter/material.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/pages/cambiar_contra/cambiar_contra_form/cambiar_contra_form.dart';

class CambiarContraPage extends StatefulWidget {
  const CambiarContraPage({super.key});

  @override
  State<CambiarContraPage> createState() => _CambiarContraPageState();
}

class _CambiarContraPageState extends State<CambiarContraPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Icon(Icons.password, color: Colors.white),
              ),
              Text(
                "Cambiar Contraseña",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),

          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          titleSpacing:
              20, // Espaciado entre el ícono/botón de retroceso y el texto del título
          centerTitle: false, // Alinea el texto del título a la izquierda
          backgroundColor: Enviroment.secondaryColor,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: const CambiarContraForm(),
              )
            ])
          ]),
        )));
  }
}
