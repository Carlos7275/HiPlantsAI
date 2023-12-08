import 'package:flutter/material.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/pages/recorridos/form/recorridos.form.dart';

class RecorridosPage extends StatefulWidget {
  const RecorridosPage({super.key});

  @override
  State<RecorridosPage> createState() => __RecorridosPagStateState();
}

class __RecorridosPagStateState extends State<RecorridosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Row(
              children: [
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.add_road,
                      color: Colors.white,
                    )),
                Text(
                  " Mis recorridos",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            titleSpacing:
                10, // Espaciado entre el ícono/botón de retroceso y el texto del título
            centerTitle: false, // Alinea el texto del título a la izquierda
            backgroundColor: Enviroment.secondaryColor),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: const RecorridosForm(),
              )
            ])
          ]),
        )));
  }
}
