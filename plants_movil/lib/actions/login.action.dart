import 'package:plants_movil/generics/redux/app.action.dart';
import 'package:plants_movil/generics/redux/app.state.dart';
import 'package:plants_movil/models/Usuario.model.dart';
import 'package:plants_movil/utilities/local_persistance.dart';

class LoginAction extends AppAction {
  String token;
  Usuario user;

  LoginAction(this.user, this.token);

  @override
  AppState reduce(AppState state) {
    LocalPersistance.instance.jwt = token;

    state.user = user;
    state.token = token;

    return state;
  }
}
