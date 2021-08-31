import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealbook/common/api/dio/dio_utils.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:mealbook/common/logger/logger.dart';
import 'package:mealbook/common/routes.dart';
import 'package:mealbook/home/bloc/home_bloc.dart';
import 'package:mealbook/home/bloc/home_event.dart';
import 'package:mealbook/home/bloc/home_repository.dart';
import 'package:mealbook/home/home_page.dart';
import 'package:mealbook/intro/intro_page.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_bloc.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_event.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_repository.dart';
import 'package:mealbook/recipe_detailed/recipe_detailed_page.dart';
import 'package:mealbook/search/search_page.dart';

class RoutesFactory {
  const RoutesFactory({
    required DioUtils dioUtils,
    required Logger logger,
  })  : _dioUtils = dioUtils,
        _logger = logger;

  final DioUtils _dioUtils;
  final Logger _logger;

  static String get initialRoute => Routes.intro;

  Map<String, Widget Function(BuildContext)> get _routes => {
        Routes.intro: (context) => const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: IntroPage(),
            ),
        Routes.home: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => ErrorHandlerBloc(_logger)),
                BlocProvider(
                  create: (context) => HomeBloc(
                    homeRepository: HomeRepository(_dioUtils),
                    errorHandlerBloc:
                        BlocProvider.of<ErrorHandlerBloc>(context),
                  )..add(HomeEventInitial()),
                ),
              ],
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: HomePage(),
              ),
            ),
        Routes.search: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: SearchPage(query: args),
          );
        },
        Routes.recipeDetailed: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ErrorHandlerBloc(_logger)),
              BlocProvider(
                create: (context) => RecipeDetailedBloc(
                  recipeDetailedRepository: RecipeDetailedRepository(_dioUtils),
                  errorHandlerBloc: BlocProvider.of<ErrorHandlerBloc>(context),
                )..add(RecipeDetailedEventInitial(id: args)),
              ),
            ],
            child: const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: RecipeDetailedPage(),
            ),
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
