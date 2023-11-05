import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/models/CodigosPostales.model.dart';
import 'package:plants_movil/models/Generos.model.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/pages/usuario/usuario_form/usuario.controller.dart';
import 'package:plants_movil/services/codigospostales.service.dart';
import 'package:plants_movil/services/generos.service.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:plants_movil/widgets/InputText/inputtext.widget.dart';

// ignore: must_be_immutable
class UsuarioForm extends StatefulWidget {
  UsuarioForm({super.key, required this.infoUsuario});
  Usuario? infoUsuario;
  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends Stateful<UsuarioForm, UsuarioFormController> {
  Usuario? infoUsuario;
  String? imagen;
  String? bytes;
  Generos? _generoSeleccionado;
  CodigosPostales? _asentamientoSeleccionado;

  List<Generos>? listadoGeneros;
  List<CodigosPostales>? listadoAsentamientos;

  @override
  void initState() {
    super.initState();
    controller.isLoading$.add(true);
    llenarGeneros();
    llenarAsentamientos(widget.infoUsuario!.cp!, startApp: true);
  }

  void llenarAsentamientoIngresado(String? cadena) {
    _asentamientoSeleccionado = null;

    if (cadena!.length == 5) {
      listadoAsentamientos = null;
      llenarAsentamientos(cadena);
    }
  }

  Future llenarAsentamientos(String cp, {bool startApp = false}) async {
    var asentamientos = await CodigosPostalesService().obtenerAsentamientos(cp);
    setState(() {
      listadoAsentamientos = asentamientos;
      if (startApp == true) {
        _asentamientoSeleccionado = listadoAsentamientos?.firstWhere(
            (element) =>
                element.idAsentaCpcons == widget.infoUsuario!.idAsentaCpcons);
        controller.isLoading$.add(false);
      }
    });
  }

  Future llenarGeneros() async {
    var generos = await GenerosService().obtenerGeneros();
    setState(() {
      listadoGeneros = generos;
      _generoSeleccionado = listadoGeneros?.firstWhere(
          (element) => element.idGenero == widget.infoUsuario!.idGenero);
      controller.isLoading$.add(false);
    });
  }

  void getImage(ImageSource media) async {
    ImagePicker picker = ImagePicker();
    var img = await picker.pickImage(source: media);

    List<int> imageBytes = await img!.readAsBytes();
    final mimeType = lookupMimeType(img.path);

    setState(() {
      bytes = base64Encode(imageBytes);
      imagen = "data:${mimeType ?? "image/png"};base64,$bytes";
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

    return StreamBuilder<bool>(
        stream: controller.isLoading$,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.data!) {
            return Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Center(
                      child: Column(
                    children: [
                      bytes != null
                          ? CircleAvatar(
                              backgroundColor: Colors
                                  .transparent, // Para que el fondo sea transparente
                              radius: 80,
                              child: ClipOval(
                                child: Image.memory(
                                  base64Decode(bytes!),
                                  width:
                                      160, // El ancho de la imagen dentro del círculo
                                  height:
                                      160, // La altura de la imagen dentro del círculo
                                  fit: BoxFit
                                      .cover, // Para cubrir completamente el espacio del CircleAvatar
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(
                                Enviroment.server +
                                    widget.infoUsuario!.urlImagen!,
                              ),
                              radius: 80,
                            ),
                      spaceBetween,
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
                              "Cambiar Foto",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
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
                        child: DropdownButtonFormField<Generos>(
                          value: _generoSeleccionado,
                          validator: Utilities.generosValidator,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          onChanged: (Generos? newValue) {
                            setState(() {
                              _generoSeleccionado = newValue!;
                            });
                          },

                          items: listadoGeneros?.map<DropdownMenuItem<Generos>>(
                              (Generos genero) {
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
                  DateTimePicker(
                    controller: controller.controllers[6],
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Fecha de nacimiento',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[4],
                          callback: Utilities.domicilioValidator,
                          onchanged: llenarAsentamientoIngresado,
                          message: "Codigo Postal",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<CodigosPostales>(
                          value: _asentamientoSeleccionado,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          onChanged: (CodigosPostales? newValue) {
                            setState(() {
                              _asentamientoSeleccionado = newValue!;
                            });
                          },
                          validator: Utilities.asentamientoValidator,
                          items: listadoAsentamientos
                              ?.map<DropdownMenuItem<CodigosPostales>>(
                                  (CodigosPostales genero) {
                            return DropdownMenuItem<CodigosPostales>(
                              value: genero,
                              child: Text(genero.dAsenta!),
                            );
                          }).toList(),
                          hint: const Text(
                              'Selecciona su colonia'), // Texto que se muestra por defecto
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[5],
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
                              backgroundColor: MaterialStateProperty.all(
                            Colors.blue,
                          )),
                          onPressed: () => setState(() {
                            controller.enviar(context, _generoSeleccionado,
                                _asentamientoSeleccionado, imagen);
                          }),
                          label: const Column(
                            children: [
                              Text(
                                "Guardar Cambios",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
