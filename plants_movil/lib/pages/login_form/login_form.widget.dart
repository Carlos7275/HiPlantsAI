import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/pages/login_form/login_form.controller.dart';
import 'package:plants_movil/widgets/InputText/inputtext.widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends Stateful<LoginForm, LoginFormController> {
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
                Row(
                  children: [
                    Expanded(
                      child: InputText(
                        controller: controller.emailController,
                        callback: controller.emailValidator,
                        icon: const Icon(Icons.alternate_email),
                        message: "Ingrese su Correo electronico",
                      ),
                    ),
                  ],
                ),
                spaceBetween,
                Row(
                  children: [
                    Expanded(
                      child: InputText(
                        callback: controller.passwordValidator,
                        controller: controller.passwordController,
                        message: "Ingrese su contraseña",
                        icon: const Icon(Icons.lock),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Center(
                      child: GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text("¿Se te olvido la contraseña?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromARGB(255, 6, 6, 6))),
                          ),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }),
                    ),
                    spaceBetween,
                    
                    GestureDetector(
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("¿No tienes cuenta haz click aqui?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 6, 6, 6))),
                        ),
                        onTap: () {
                          // do what you need to do when "Click here" gets clicked
                        }),
                  ],
                ),
                spaceBetween,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 10)),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () => controller.login(context),
                        child: const Text(
                          "Iniciar Sesion",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                spaceBetween,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 4)),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () {
                          exit(1);
                        },
                        child: const Text(
                          "Salir",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
            strokeWidth: 4,
          );
        }
      },
    );
  }
}
