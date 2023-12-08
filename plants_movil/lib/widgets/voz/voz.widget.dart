import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:plants_movil/models/Comandos.model.dart';
import 'package:plants_movil/services/comandos.service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:string_similarity/string_similarity.dart';

class Voz extends StatefulWidget {
  const Voz({super.key});
  @override
  _VozState createState() => _VozState();
}

class _VozState extends State<Voz> {
  FlutterTts tts = FlutterTts();
  DateTime lastCommandTime = DateTime.now();
  int cooldownSeconds = 10;
  List<Comandos>? comandos;
  String texto = 'Por favor ingrese un comando de voz.';
  bool estaEscuchando = false;
  SpeechToText spt = SpeechToText();
  late AlertDialog alertDialog;
  LatLng coordenadas = const LatLng(0, 0);
  List<String>? comandoList;
  @override
  void initState() {
    super.initState();
    obtenerComandos();
  }

  void obtenerComandos() async {
    comandos = await ComandosService().obtenerComandos();
    await obtenerUbicacionUsuario();

    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) async {
    await tts.setVolume(1);
    await tts.pause();
    setState(() {
      texto = result.recognizedWords;
    });

    alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Busqueda de Voz'),
      content: Text(texto),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            await spt.cancel();
            // Utiliza Navigator.of(context, rootNavigator: true).pop() para cerrar solo el modal.
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );

    setState(() {
      estaEscuchando = false;
    });

    double maxSimilarity = 0.0;
    Comandos matchedCommand = Comandos(comando: '', descripcion: '');

    for (Comandos cmd in comandos!) {
      double similarity = texto.similarityTo(cmd.comando);
      if (similarity > maxSimilarity) {
        maxSimilarity = similarity;
        matchedCommand = cmd;
      }
    }

    double threshold = 0.5;

    if (maxSimilarity >= threshold) {
      // Execute actions based on the command
      print('Comando detectado: ${matchedCommand.descripcion}');
      print('Descripción: ${matchedCommand.descripcion}');
      print("id ${matchedCommand.id}");

      await ejecutarComando(matchedCommand.id);
    } else {
      // Check if a cooldown period has passed before announcing "No se detectó ningún comando"
      if (!estaEscuchando &&
          DateTime.now().difference(lastCommandTime).inSeconds >
              cooldownSeconds) {
        await tts.speak("¡No se detectó ningún comando!");
        // Update the last command time
        lastCommandTime = DateTime.now();
      }
    }

    // Usa Navigator.of(context, rootNavigator: true).pop() para cerrar solo el modal.
    Navigator.of(context, rootNavigator: true).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  Future<void> obtenerUbicacionUsuario() async {
    bool servicio = await Geolocator.isLocationServiceEnabled();

    if (servicio) {
      const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);

      Position position = await Geolocator.getCurrentPosition();
      coordenadas = LatLng(position.latitude, position.longitude);
    } else {
      await AppSettings.openAppSettings(type: AppSettingsType.location);
    }
  }

  ejecutarComando(id) async {
    FlutterTts tts = FlutterTts();
    await obtenerUbicacionUsuario();

    switch (id) {
      case 1:
        var mensaje = await ComandosService().plantaNoVisitadas();
        await tts.speak(mensaje);
        break;
      case 2:
        var mensaje = await ComandosService()
            .plantaCercanas(coordenadas.latitude, coordenadas.longitude);
        await tts.speak(mensaje);
        break;
      case 3:
        var mensaje = await ComandosService().plantaMasVisitada();
        await tts.speak(mensaje);
        break;
      case 4:
        var mensaje = await ComandosService().plantaMasVisitadaTiempo();
        await tts.speak(mensaje);
        break;

      case 5:
        var mensaje = await ComandosService().plantaMenosVisitadaTiempo();
        await tts.speak(mensaje);
        break;

      case 6:
        var mensaje = await ComandosService().areaMasVisitada();
        await tts.speak(mensaje);
        break;
      case 7:
        var mensaje = await ComandosService().areaMasVisitada();
        await tts.speak(mensaje);
        break;
      case 8:
        var mensaje = await ComandosService()
            .plantaCercanasToxicas(coordenadas.latitude, coordenadas.longitude);
        await tts.speak(mensaje);
        break;
      case 9:
        var mensaje = await ComandosService().plantaCercanasNoToxicas(
            coordenadas.latitude, coordenadas.longitude);
        await tts.speak(mensaje);
        break;
      case 10:
        var mensaje = await ComandosService()
            .areasCercanas(coordenadas.latitude, coordenadas.longitude);
        await tts.speak(mensaje);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.mic),
            hoverColor: Colors.grey,
            onPressed: () async {
              // Establecer el texto predeterminado antes de mostrar el diálogo.
              texto = 'Por favor ingrese un comando de voz.';
              alertDialog = AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Busqueda de Voz'),
                content: Text(texto),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      await spt.cancel();
                      // Utiliza Navigator.of(context, rootNavigator: true).pop() para cerrar solo el modal.
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alertDialog;
                },
              );
              var disponible = await spt.initialize();
              if (disponible) {
                setState(() {
                  estaEscuchando = true;
                });

                await spt.listen(
                    onResult: resultListener,
                    listenFor: const Duration(seconds: 10));
              }
            },
          ),
          if (comandos != null)
            IconButton(
              onPressed: () {
                comandoList = comandos!.map((e) => e.comando!).toList();
                alertDialog = AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text('Comandos de voz'),
                  content: SingleChildScrollView(
                      child: Text(comandoList!.join(",\n"))),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Cerrar',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        // Utiliza Navigator.of(context, rootNavigator: true).pop() para cerrar solo el modal.
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  ],
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alertDialog;
                  },
                );
              },
              icon: const Icon(Icons.help),
            ),
        ],
      ),
    );
  }
}
