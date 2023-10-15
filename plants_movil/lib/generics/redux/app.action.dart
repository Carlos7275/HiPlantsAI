import 'package:plants_movil/generics/redux/app.state.dart';

abstract class AppAction {
  AppState reduce(AppState state);
}
