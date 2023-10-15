import 'package:plants_movil/generics/redux/app.action.dart';
import 'package:plants_movil/generics/redux/app.state.dart';
import 'package:redux/redux.dart';

class AppStore extends Store<AppState> {
  static final AppStore _store = AppStore._privateConstructor(
      (AppState state, action) => (action as AppAction).reduce(state),
      initialState: AppState());
  factory AppStore() => _store;

  AppStore._privateConstructor(
    AppState Function(AppState, dynamic) reducer, {
    required AppState initialState,
    List<dynamic Function(Store<AppState>, dynamic, dynamic Function(dynamic))>
        middleware = const [],
    bool syncStream = false,
    bool distinct = false,
  }) : super(reducer,
            initialState: initialState,
            middleware: middleware,
            syncStream: syncStream,
            distinct: distinct);
}
