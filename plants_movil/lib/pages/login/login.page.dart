import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/env/local.env.dart';
import 'package:plants_movil/pages/login/login_form/login_form.widget.dart';
import 'package:plants_movil/services/usuario.service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    logged();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.forward(from: 10);
      }
    });

    animationController.addListener(() {
      setState(() {});
    });

    animationController.forward();
  }

  void logged() async {
    bool isLogged = await UsuarioService().isLogin();
    if (isLogged) {
      Modular.to.pushNamed("home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    transform: GradientRotation(animationController.value),
                    colors: const [
                  Enviroment.primaryColor,
                  Enviroment.secondaryColor,
                ])),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 80,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Iniciar Sesión",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Bienvenido a Hi Plants AI",
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Contenedor donde se pondran los inputs
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(children: [
                              Column(children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const LoginForm(),
                                )
                              ])
                            ]),
                          ),
                        )),
                  )
                ])));
  }
}
