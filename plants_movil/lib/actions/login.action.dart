import 'package:plants_movil/generics/redux/app.action.dart';
import 'package:plants_movil/generics/redux/app.state.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/utilities/local_persistance.dart';

class LoginAction extends AppAction {
  Usuario user;

  LoginAction(this.user);

  @override
  AppState reduce(AppState state) {
    state.user = user;

    return state;
  }
}
