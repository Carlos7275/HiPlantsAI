import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/pages/cambiar_contra/cambiar_contra_form/cambiar_contra.controller.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:plants_movil/widgets/InputText/inputtext.widget.dart';

class CambiarContraForm extends StatefulWidget {
  const CambiarContraForm({super.key});
  @override
  State<CambiarContraForm> createState() => _CambiarContraState();
}


class _CambiarContraState extends Stateful<CambiarContraForm, CambiarContraController> {
 //comenzamos a crear el diseño de la pagina
  @override
  Widget build(BuildContext context) {
    Container spaceBetween = Container(
        height: 15); //creamos la variable para el salto entre componentes
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
                    child: Image.asset('assets/images/imgcontra.jpg', width: 150),
                  ),
                  spaceBetween,

                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[0],
                          obscure: true,
                          callback: Utilities.passwordValidator,
                          icon: const Icon(Icons.lock),
                          message: "Ingrese su contraseña actual",
                        ),
                      ),
                    ],
                  ),
                  spaceBetween, //espaciado

                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[1],
                          obscure: true,
                          callback: Utilities.passwordValidator,
                          icon: const Icon(Icons.lock),
                          message: "Ingrese la contraseña nueva",
                        ),
                      ),
                    ],
                  ),
                  spaceBetween, //espaciado

                  Row(
                    children: [
                      Expanded(
                        child: InputText(
                          controller: controller.controllers[2],
                          obscure: true,
                          callback: controller.verificarPassword,
                          icon: const Icon(Icons.lock),
                          message: "Reingrese la contraseña",
                        ),
                      ),
                    ],
                  ),
                  spaceBetween, //espaciado

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
                            controller.enviar(context);
                          }),
                          label: const Column(
                            children: [
                              Text(
                                "Guardar cambios",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

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
