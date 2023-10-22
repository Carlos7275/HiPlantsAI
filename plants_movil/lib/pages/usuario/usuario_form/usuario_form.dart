import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/models/Generos.model.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/pages/usuario/usuario_form/usuario.controller.dart';
import 'package:plants_movil/services/generos.service.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:plants_movil/widgets/InputText/inputtext.widget.dart';

class UsuarioForm extends StatefulWidget {
  UsuarioForm({super.key, required this.infoUsuario});
  Usuario infoUsuario;
  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends Stateful<UsuarioForm, UsuarioFormController> {
  Usuario? infoUsuario;
  String? imagen;
  String? bytes;
  Generos? _generoSeleccionado;

  List<Generos>? list;
  @override
  void initState() {
    super.initState();
    setState(() {
      llenarGeneros();
    });
  }

  Future<List<Generos>> llenarGeneros() async {
    return await GenerosService().obtenerGeneros();
  }

  void getImage(ImageSource media) async {
    ImagePicker picker = ImagePicker();
    var img = await picker.pickImage(source: media);

    List<int> imageBytes = await img!.readAsBytes();
    final mimeType = lookupMimeType(img.path);
    setState(() {
      bytes = base64Encode(imageBytes);
      imagen = "data:$mimeType;base64,$bytes";
    });
  }

  void pickupImage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Por favor seleccione el medio'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 5)),
                        backgroundColor: MaterialStateProperty.all(
                          Enviroment.secondaryColor,
                        )),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text(
                          'Desde la Galeria',
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 5)),
                        backgroundColor: MaterialStateProperty.all(
                          Enviroment.secondaryColor,
                        )),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text(
                          'Desde la Camara',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Container spaceBetween = Container(height: 15);

    return FutureBuilder<List<Generos>>(
      future: llenarGeneros(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Enviroment.secondaryColor,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading genres: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No genres available.'));
        } else {
          list = snapshot.data;
          return formulario(
              spaceBetween, context); // Replace this with your form widget
        }
      },
    );
  }

  Form formulario(Container spaceBetween, BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Center(
              child: Column(
            children: [
              bytes != null
                  ? ClipRect(
                      child: Image.memory(
                      base64Decode(bytes!),
                      width: 100,
                    ))
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                        Enviroment.server + widget.infoUsuario.urlImagen!,
                      ),
                      radius: 50,
                    ),
              spaceBetween,
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 5)),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    )),
                onPressed: () async => pickupImage(),
                label: const Column(
                  children: [
                    Text(
                      "Cambiar Foto",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          )),
          Row(
            children: [
              Expanded(
                child: InputText(
                  controller: controller.controllers[0],
                  callback: Utilities.emailValidator,
                  icon: const Icon(Icons.alternate_email),
                  message: "Correo Electronico",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: InputText(
                  controller: controller.controllers[1],
                  callback: Utilities.nameValidator,
                  icon: const Icon(Icons.info),
                  message: "Nombres",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: InputText(
                  controller: controller.controllers[2],
                  callback: Utilities.apellidoValitador,
                  message: "Apellido Paterno",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: InputText(
                  controller: controller.controllers[3],
                  callback: Utilities.apellidoValitador,
                  message: "Apellido Materno",
                ),
              ),
            ],
          ),
          spaceBetween,
          Row(
            children: [
              Expanded(
                child: DropdownButton<Generos>(
                  value: list?.firstWhere((element) =>
                      element.idGenero == widget.infoUsuario.idGenero),
                  onChanged: (Generos? newValue) {
                    setState(() {
                      _generoSeleccionado = newValue!;
                    });
                  },
                  items: list?.map<DropdownMenuItem<Generos>>((Generos genero) {
                    return DropdownMenuItem<Generos>(
                      value: genero,
                      child: Text(genero.descripcion!),
                    );
                  }).toList(),
                  hint: const Text(
                      'Selecciona un género'), // Texto que se muestra por defecto
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: InputText(
                  controller: controller.controllers[4],
                  callback: Utilities.domicilioValidator,
                  message: "Domicilio",
                  icon: const Icon(Icons.maps_home_work),
                ),
              ),
            ],
          ),
          spaceBetween,
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 5)),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue,
                      )),
                  onPressed: () => controller.enviar(context),
                  label: const Column(
                    children: [
                      Text(
                        "Guardar Cambios",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          spaceBetween,
        ],
      ),
    );
  }
}
