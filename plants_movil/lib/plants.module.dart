import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/generics/redux/app.store.dart';

import 'package:plants_movil/pages/login/login_form/login_form.controller.dart';
import 'package:plants_movil/routes.dart';
import 'package:plants_movil/services/usuario.service.dart';
import 'package:plants_movil/utilities/local_persistance.dart';

class PlantsModule extends Module {
  @override
  List<Bind> get binds => [
        // Bind.instance(LocalPersistance.instance),
        Bind.singleton((i) => AppStore()),
        Bind.singleton((i) => UsuarioService()),
        Bind.factory((i) => LoginFormController(i<AppStore>()))
      ];

  @override
  List<ModularRoute> get routes => _mappingRoutes<ModularRoute>(myRoutes);

  List<T> _mappingRoutes<T>(List<RouteFunction> routes) {
    return routes
        .map<T>((route) => (ChildRoute(route.url,
            child: route.function,
            children: _mappingRoutes<ParallelRoute>(route.children)) as T))
        .toList();
  }
}
