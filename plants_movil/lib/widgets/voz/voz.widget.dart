import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Voz extends StatefulWidget {
  const Voz({super.key});
  @override
  _VozState createState() => _VozState();
}

class _VozState extends State<Voz> {
  String texto = 'Por favor ingrese un comando de voz.';
  bool estaEscuchando = false;
  SpeechToText spt = SpeechToText();
  late AlertDialog alertDialog;

  void resultListener(SpeechRecognitionResult result) {
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

    // Usa Navigator.of(context, rootNavigator: true).pop() para cerrar solo el modal.
    Navigator.of(context, rootNavigator: true).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
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
    );
  }
}
