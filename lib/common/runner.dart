import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealbook/app.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  _runApp();
}

void _runApp() {
  runZonedGuarded<Future<void>>(
    () async => runApp(const App()),
    (object, stackTrace) {},
  );
}
