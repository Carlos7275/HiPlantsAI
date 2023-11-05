import 'dart:async';
import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsNotLoginGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    bool islogged = await UsuarioService().isLogin();
    if (islogged) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      UsuarioService().me().then((value) =>
          preferences.setString("info_usuario", jsonEncode(value["data"])));
      Modular.to.pushNamed("/home");
    }

    return true;
  }
}
