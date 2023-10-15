import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/generics/redux/app.state.dart';
import 'package:plants_movil/generics/redux/app.store.dart';
import 'package:plants_movil/pages/login_form/login_form.controller.dart';
import 'package:plants_movil/services/usuario.service.dart';

class PlantsModule extends Module {
  @override
  void binds(i) {
    i.addInstance(AppState());
    i.addInstance(AppStore());
    i.addInstance(UsuarioService());
    i.addInstance(LoginFormController());
  }
}
