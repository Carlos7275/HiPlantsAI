import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:plants_movil/plants.module.dart';
import 'package:plants_movil/plants.widget.dart';

void main() {
  runApp(ModularApp(module: PlantsModule(), child: const PlantsWidget()));
}