import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/services/usuario.service.dart';

class IsLoginGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    bool islogged = await UsuarioService().isLogin();
    if (islogged) return true;

    return false;
  }
}
