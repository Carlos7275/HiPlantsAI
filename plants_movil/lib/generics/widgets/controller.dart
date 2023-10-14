import 'package:flutter_modular/flutter_modular.dart';

abstract class Controller implements Disposable {
  @override
  void dispose() {}
  void deactivate() {}
  void didChangeDependencies() {}
  void didUpdateWidget(oldWidget) {}
  void activate() {}
}