import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/pages/registrar_plantas/registrar_plantas_form/registro_plantas.controller.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:plants_movil/widgets/InputText/inputtext.widget.dart';
import 'package:mime/mime.dart';
import 'package:plants_movil/widgets/space/space.widget.dart';

class RegistroPlantasForm extends StatefulWidget {
  const RegistroPlantasForm({super.key});
  @override
  State<RegistroPlantasForm> createState() => _RegistroPlantasForm();
}

class _RegistroPlantasForm
    extends Stateful<RegistroPlantasForm, RegistroPlantasController> {
  String? bytes;
  String? imagen;
  @override
  void initState() {
    super.initState();
  }

  Future getImage(ImageSource media) async {
    ImagePicker picker = ImagePicker();
    var img = await picker.pickImage(source: media);

    List<int> imageBytes = await img!.readAsBytes();
    final mimeType = lookupMimeType(img.path);

    setState(() {
      bytes = base64Encode(imageBytes);
      imagen = "data:${mimeType ?? "image/png"};base64,$bytes";
    });
  }

  void pickupImage() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const Text('Por favor seleccione el medio'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 5),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Enviroment.secondaryColor,
                    ),
                  ),
                  onPressed: () async {
                    await getImage(ImageSource.gallery);
                    Navigator.pop(context, true);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      Text('Desde la Galeria'),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 5),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Enviroment.secondaryColor,
                    ),
                  ),
                  onPressed: () async {
                    await getImage(ImageSource.camera);
                    Navigator.pop(context, true);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.camera),
                      Text('Desde la Camara'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: controller.isLoading$,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.data!) {
            return Form(
              key: controller.formKey,
              child: Column(
                children: [
                  bytes != null
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100,
                          child: ClipOval(
                            child: Image.memory(
                              base64Decode(bytes!),
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          child: Image.asset('assets/images/image.png',
                              width: 250),
                        ),
                  Space.espaciador(15),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.grey,
                    )),
                    onPressed: () async => pickupImage(),
                    label: const Column(
                      children: [
                        Text(
                          "Ingresar Imagen",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Space.espaciador(15),
                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          icon: const Icon(Icons.map),
                          controller: controller.controllers[0],
                          message: "Latitud",
                          callback: Utilities.latitudValidator,
                        ),
                      ),
                    ],
                  ),
                  Space.espaciador(15),
                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          icon: const Icon(Icons.map),
                          controller: controller.controllers[1],
                          message: "Longitud",
                          callback: Utilities.longitudValidator,
                        ),
                      ),
                    ],
                  ),
                  Space.espaciador(15),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.location_on),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Enviroment.secondaryColor,
                    )),
                    onPressed: () async {
                      controller.obtenerUbicacionUsuario();
                    },
                    label: const Column(
                      children: [
                        Text(
                          "Obtener Ubicacion Actual",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Space.espaciador(15),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    )),
                    onPressed: () async => controller.enviar(context, imagen),
                    label: const Column(
                      children: [
                        Text(
                          "Guardar",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    strokeWidth: 5),
              ),
            );
          }
        });
  }
}
