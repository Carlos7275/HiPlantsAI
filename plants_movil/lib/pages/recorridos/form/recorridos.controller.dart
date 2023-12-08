import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/models/Recorridos.model.dart';
import 'package:plants_movil/services/Recorridos.service.dart';
import 'package:rxdart/rxdart.dart';

class RecorridosController extends Controller {
  final TextEditingController fechainicialcontroller = TextEditingController();
  final TextEditingController fechafinalcontroller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);
  List<Recorridos> puntos = List.empty();

  RecorridosController() {
    DateTime fechaActual = DateTime.now();
    fechainicialcontroller.text =
        DateTime(fechaActual.year, fechaActual.month, 1).toString();
    fechafinalcontroller.text =
        DateTime(fechaActual.year, fechaActual.month + 1, 0).toString();
    obtenerPlantas();
  }

  Future obtenerPlantas() async {
    puntos = await RecorridosService().obtenerRecorridos(
        fechafinalcontroller.text, fechafinalcontroller.text);
  }

  enviar(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading$.add(true);
      puntos = await RecorridosService().obtenerRecorridos(
          fechainicialcontroller.text, fechafinalcontroller.text);
      isLoading$.add(false);
    }
  }
}
