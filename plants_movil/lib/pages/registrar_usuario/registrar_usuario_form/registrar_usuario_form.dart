import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/models/CodigosPostales.model.dart';
import 'package:plants_movil/models/Generos.model.dart';
import 'package:plants_movil/pages/registrar_usuario/registrar_usuario_form/registrar_usuario.controller.dart';
import 'package:plants_movil/services/codigospostales.service.dart';
import 'package:plants_movil/services/generos.service.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:plants_movil/widgets/InputText/inputtext.widget.dart';
import 'package:plants_movil/widgets/space/space.widget.dart';

class RegistrarUsuarioForm extends StatefulWidget {
  const RegistrarUsuarioForm({super.key});
  @override
  State<RegistrarUsuarioForm> createState() => _RegistraUsuarioState();
}

class _RegistraUsuarioState
    extends Stateful<RegistrarUsuarioForm, RegistrarUsuarioController> {
  Generos? _generoSeleccionado;
  CodigosPostales? _asentamientoSeleccionado;
  List<Generos>? listadoGeneros;
  List<CodigosPostales>? listadoAsentamientos;

  @override
  void initState() {
    super.initState();
    llenarGeneros();
  }

  void llenarAsentamientoIngresado(String? cadena) {
    setState(() {
      _asentamientoSeleccionado = null;

      if (cadena!.length == 5) {
        listadoAsentamientos = null;
        llenarAsentamientos(cadena);
      }
    });
  }

  Future llenarAsentamientos(String cp) async {
    var asentamientos = await CodigosPostalesService().obtenerAsentamientos(cp);
    setState(() {
      listadoAsentamientos = asentamientos;
    });
  }

  Future llenarGeneros() async {
    var generos = await GenerosService().obtenerGeneros();
    setState(() {
      listadoGeneros = generos;
    });
  }

  //comenzamos a crear el diseño de la pagina
  @override
  Widget build(BuildContext context) {
    //creamos la variable para el salto entre componentes
    return StreamBuilder<bool>(
        stream: controller.isLoading$,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.data!) {
            return Form(
              key: controller.formKey,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset('assets/images/user.png', width: 150),
                  ),
                  Space.espaciador(15),
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
                          obscure: true,
                          callback: Utilities.passwordValidator,
                          icon: const Icon(Icons.lock),
                          message: "Password",
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[8],
                          obscure: true,
                          callback: controller.verificarPassword,
                          icon: const Icon(Icons.lock),
                          message: "Reingrese la contraseña",
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[2],
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
                          controller: controller.controllers[3],
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
                          controller: controller.controllers[4],
                          callback: Utilities.apellidoValitador,
                          message: "Apellido Materno",
                        ),
                      ),
                    ],
                  ),
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
                    controller: controller.controllers[7],
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Fecha de nacimiento',
                    validator: Utilities.fechaNacimientoValidator,
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
                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[6],
                          callback: Utilities.codigopostalValidator,
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

                   Space.espaciador(15), //e|spaciado
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                            Colors.blue,
                          )),
                          onPressed: () => setState(() {
                            controller.enviar(context, _generoSeleccionado,
                                _asentamientoSeleccionado);
                          }),
                          label: const Column(
                            children: [
                              Text(
                                "Registrarse",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                   Space.espaciador(15), //espaciado
                ], //children
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
