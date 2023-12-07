import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:plants_movil/models/Comandos.model.dart';
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
  List<Comandos>? comandos;
  String texto = 'Por favor ingrese un comando de voz.';
  bool estaEscuchando = false;
  SpeechToText spt = SpeechToText();
  late AlertDialog alertDialog;

  List<String>? comandoList;
  @override
  void initState() {
    super.initState();
    obtenerComandos();
  }

  void obtenerComandos() async {
    comandos = await ComandosService().obtenerComandos();
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) async {
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
    // Busca el comando con mayor similitud
    double maxSimilarity = 0.0;
    Comandos matchedCommand = Comandos(comando: '', descripcion: '');

    for (Comandos cmd in comandos!) {
      double similarity = texto.similarityTo(cmd.comando);
      if (similarity > maxSimilarity) {
        maxSimilarity = similarity;
        matchedCommand = cmd;
      }
    }

    // Establece un umbral de similitud para considerar el comando como coincidente
    double threshold = 0.5;

    if (maxSimilarity >= threshold) {
      // Ejecutar acciones basadas en el comando

      print('Comando detectado: ${matchedCommand.descripcion}');
      print('Descripción: ${matchedCommand.descripcion}');
      print("id ${matchedCommand.id}");

      await ejecutarComando(matchedCommand.id);
    } else {
      FlutterTts().speak("¡No se detecto ningun comando!");
      FlutterTts().stop();
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

  ejecutarComando(id) async {
    FlutterTts tts = FlutterTts();
    switch (id) {
      case 3:
        var mensaje = await ComandosService().plantaMasVisitada();
        print(mensaje);
        tts.speak(mensaje);
        tts.stop();
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

                await spt.listen(onResult: resultListener);
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
                  content: Text(comandoList!.join(",\n")),
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
            )
        ],
      ),
    );
  }
}
