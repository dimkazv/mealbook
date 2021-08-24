import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template_bloc/common/routes.dart';
import 'package:template_bloc/home/home_page.dart';

class RoutesFactory {
  static String get initialRoute => Routes.home;

  Map<String, Widget Function(BuildContext)> get _routes => {
        Routes.home: (context) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: HomePage(),
          );
        },
      };

  Route<dynamic> getGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (context) => _routes[settings.name]!(context),
        );
    }
  }
}
