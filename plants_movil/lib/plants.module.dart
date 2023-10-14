import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/pages/login_form/login_form.controller.dart';

class PlantsModule extends Module {
  @override
  void binds(i) {
    i.addInstance(LoginFormController());
  }
}
