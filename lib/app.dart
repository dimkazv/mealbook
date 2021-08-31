import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mealbook/common/api/dio/dio_utils.dart';
import 'package:mealbook/common/env/config.dart';
import 'package:mealbook/common/env/debug_options.dart';
import 'package:mealbook/common/env/environment.dart';
import 'package:mealbook/common/logger/production_logger.dart';
import 'package:mealbook/common/routes_factory.dart';
import 'package:mealbook/common/ui/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  DebugOptions get _debug => Environment<Config>.instance().config.debugOptions;

  @override
  Widget build(BuildContext context) {
    final routesFactory = RoutesFactory(
      logger: ProductionLogger(),
      dioUtils: DioUtils(
        dio: Dio(
          BaseOptions(
            baseUrl: Environment<Config>.instance().config.apiBaseUrl,
            connectTimeout: 60 * 1000,
            receiveTimeout: 60 * 1000,
          ),
        ),
        logging: true,
      ),
    );
    return MaterialApp(
      showPerformanceOverlay: _debug.showPerformanceOverlay,
      debugShowMaterialGrid: _debug.debugShowMaterialGrid,
      checkerboardRasterCacheImages: _debug.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _debug.checkerboardOffscreenLayers,
      showSemanticsDebugger: _debug.showSemanticsDebugger,
      debugShowCheckedModeBanner: _debug.debugShowCheckedModeBanner,
      initialRoute: RoutesFactory.initialRoute,
      onGenerateRoute: routesFactory.getGeneratedRoutes,
      theme: lightTheme,
    );
  }
}
