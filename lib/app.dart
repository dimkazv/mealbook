import 'package:flutter/material.dart';
import 'package:mealbook/common/env/config.dart';
import 'package:mealbook/common/env/debug_options.dart';
import 'package:mealbook/common/env/environment.dart';
import 'package:mealbook/common/routes_factory.dart';
import 'package:mealbook/common/ui/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  DebugOptions get _debug => Environment<Config>.instance().config.debugOptions;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: _debug.showPerformanceOverlay,
      debugShowMaterialGrid: _debug.debugShowMaterialGrid,
      checkerboardRasterCacheImages: _debug.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _debug.checkerboardOffscreenLayers,
      showSemanticsDebugger: _debug.showSemanticsDebugger,
      debugShowCheckedModeBanner: _debug.debugShowCheckedModeBanner,
      initialRoute: RoutesFactory.initialRoute,
      onGenerateRoute: RoutesFactory().getGeneratedRoutes,
      title: 'Template Bloc',
      theme: lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
