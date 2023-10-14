import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/generics/widgets/controller.dart';

abstract class Stateful<S extends StatefulWidget,
    C extends Controller> extends State<S> {
  C controller = Modular.get<C>();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    controller.deactivate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.didChangeDependencies();
  }

  @override
  void didUpdateWidget(S oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.didUpdateWidget(oldWidget);
  }

  @override
  void activate() {
    super.activate();
    controller.activate();
  }
}