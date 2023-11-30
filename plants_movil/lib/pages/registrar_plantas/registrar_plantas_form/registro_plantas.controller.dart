import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:plants_movil/generics/widgets/controller.dart';
import 'package:plants_movil/models/Planta.model.dart';
import 'package:plants_movil/services/mapa.service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rxdart/rxdart.dart';

class RegistroPlantasController extends Controller {
  //Controladores de EdicionDeTexto
  List<TextEditingController> controllers =
      List.generate(2, (index) => TextEditingController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> isLoading$ = BehaviorSubject<bool>.seeded(false);

  Future<void> obtenerUbicacionUsuario() async {
    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const settings =
          LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

      Position position = await Geolocator.getCurrentPosition();
      controllers[0].text = position.latitude.toString();
      controllers[1].text = position.longitude.toString();
    } else {
      // If location service is not enabled, prompt the user to enable it.
      print("Location service is not enabled. Showing alert.");
    }
  }

  enviar(BuildContext context, String? imagen) {
    if (formKey.currentState!.validate() && imagen != null) {
      isLoading$.add(true);

      PlantaModel plantaModel = PlantaModel(
        latitud: double.parse(controllers[0].text),
        longitud: double.parse(controllers[1].text),
        imagen: imagen,
      );

      MapaService().registrarPlanta(plantaModel).then((value) {
        String p = value["data"]["nombre_planta"];
        QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: "¡Operación Exitosa!",
                text: 'Se registro la planta $p')
            .then((value) async {
          isLoading$.add(false);

          Modular.to.pushNamed("/home");
        });
      }).catchError((error) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: jsonDecode(error.body)["message"],
          showConfirmBtn: true,
        );
        isLoading$.add(false);
      });
    }
  }
}
