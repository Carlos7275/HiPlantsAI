
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/generics/widgets/stateful.dart';
import 'package:plants_movil/pages/login/login_form/login_form.controller.dart';
import 'package:plants_movil/utilities/regex.dart';
import 'package:plants_movil/widgets/InputText/inputtext.widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends Stateful<LoginForm, LoginFormController> {
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
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
                Row(
                  children: [
                    Expanded(
                      child: InputText(
                        controller: controller.emailController,
                        callback: Utilities.emailValidator,
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
                        callback: Utilities.passwordValidator,
                        controller: controller.passwordController,
                        obscure: true,
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
                  ],
                ),
                spaceBetween,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.login_sharp),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 5)),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () => controller.enviar(context),
                        label: const Column(
                          children: [
                            Text(
                              "Iniciar Sesion",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                spaceBetween,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_circle_outline),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 4)),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () {
                          Modular.to.pushNamed('/registrar');

                        },
                        label: const Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
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
                strokeWidth: 4,
              ),
            ),
          );
        }
      },
    );
  }
}
