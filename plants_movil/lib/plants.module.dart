import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/pages/login/login_form/login_form.controller.dart';
import 'package:plants_movil/pages/usuario/usuario_form/usuario.controller.dart';
import 'package:plants_movil/routes.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:plants_movil/pages/registrar_usuario/registrar_usuario_form/registrar_usuario.controller.dart';


class PlantsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => UsuarioService()),
        Bind.factory((i) => LoginFormController()),
        Bind.factory((i) => UsuarioFormController()),
        Bind.factory((i) => RegistrarUsuarioController ())
      ];

  @override
  List<ModularRoute> get routes => _mappingRoutes<ModularRoute>(myRoutes);

  List<T> _mappingRoutes<T>(List<RouteFunction> routes) {
    return routes
        .map<T>((route) => (ChildRoute(route.url,
            child: route.function,
            guards: route.guards,
            children: _mappingRoutes<ParallelRoute>(route.children)) as T))
        .toList();
  }
}
