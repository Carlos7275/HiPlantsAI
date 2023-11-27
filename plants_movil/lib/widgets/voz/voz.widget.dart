import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Voz extends StatefulWidget {
  Voz({super.key});
  @override
  _VozState createState() => _VozState();
}

class _VozState extends State<Voz> {
  String texto = 'Por favor ingrese un comando de voz.';
  bool estaEscuchando = false;
  SpeechToText spt = SpeechToText();
  void resultListener(SpeechRecognitionResult result) {
    print("esele mi toro");
    setState(() {
      texto = result.recognizedWords;
      print(texto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.blue,
          ),
        ),
        icon: const Icon(
          Icons.mic,
          color: Colors.white,
        ),
        onPressed: () async {
          texto = 'Por favor ingrese un comando de voz.';
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
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
    );
  }
}
