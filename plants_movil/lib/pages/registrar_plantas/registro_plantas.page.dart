import 'package:flutter/material.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/pages/registrar_plantas/registrar_plantas_form/registrar_plantas_form.dart';

class RegistrarPlantasPage extends StatefulWidget {
  const RegistrarPlantasPage({super.key});

  @override
  State<RegistrarPlantasPage> createState() => _RegistrarPlantaState();
}

class _RegistrarPlantaState extends State<RegistrarPlantasPage> {
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
                padding: EdgeInsets.all(2.0),
                child: Icon(Icons.add, color: Colors.white),
              ),
              Text(
                "Registrar Plantas",
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
                child: const RegistroPlantasForm(),
              )
            ])
          ]),
        )));
  }
}
