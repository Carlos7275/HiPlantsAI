import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plants_movil/plants.module.dart';
import 'package:plants_movil/plants.widget.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await FlutterMapTileCaching.initialise();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FMTC.instance('mapStore').manage.createAsync();
  runApp(ModularApp(module: PlantsModule(), child: const PlantsWidget()));
  FlutterNativeSplash.remove();
}
