import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
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
  int cooldownSeconds = 5;
  List<Comandos>? comandos;
  String texto = '';
  bool estaEscuchando = false;
  SpeechToText spt = SpeechToText();
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

  Future cambiarEstatus() async {
    estaEscuchando = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          GestureDetector(
            onDoubleTap: () async {
              await cambiarEstatus();
              spt.stop();
            },
            child: IconButton(
              icon: (estaEscuchando)
                  ? const Icon(Icons.mic_off)
                  : const Icon(Icons.mic),
              onPressed: () async {
                await tts.stop();

                var disponible = await spt.initialize();
                if (disponible) {
                  setState(() {
                    estaEscuchando = true;
                  });

                  await spt.listen(
                    onResult: resultListener,
                  );
                }
              },
            ),
          ),
          if (comandos != null)
            IconButton(
              onPressed: () {
                comandoList = comandos!.map((e) => e.comando!).toList();
                AlertDialog alertDialog = AlertDialog(
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

  void resultListener(SpeechRecognitionResult result) async {
    await tts.setVolume(1);
    setState(() {
      texto = result.recognizedWords;
    });
    await cambiarEstatus();

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
      if (kDebugMode) {
        print('Comando detectado: ${matchedCommand.descripcion}');
        print('Descripción: ${matchedCommand.descripcion}');
        print("id ${matchedCommand.id}");
      }
      await ejecutarComando(matchedCommand.id);
    }
  }

  ejecutarComando(id) async {
    FlutterTts tts = FlutterTts();
    await obtenerUbicacionUsuario();
    await tts.stop();
    tts.setSpeechRate(Platform.isAndroid ? 0.8 : 0.395);
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
        var mensaje = await ComandosService().areaMenosVisitadaTiempo();
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
      case 11:
        var mensaje = await ComandosService()
            .plantaCercanas(coordenadas.latitude, coordenadas.longitude);
        await tts.speak(mensaje);
        break;
      case 12:
        var mensaje = await ComandosService().plantasCercanasVegetables(
            coordenadas.latitude, coordenadas.longitude);
        await tts.speak(mensaje);
        break;

      case 13:
        var mensaje = await ComandosService().plantasCercanasComestibles(
            coordenadas.latitude, coordenadas.longitude);
        await tts.speak(mensaje);
        break;
    }
  }
}
