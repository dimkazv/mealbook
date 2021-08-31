import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/home/bloc/home_event.dart';
import 'package:mealbook/home/bloc/home_repository.dart';
import 'package:mealbook/home/bloc/home_state.dart';
import 'package:mealbook/home/models/recipe_type.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required HomeRepository homeRepository,
    required ErrorHandlerBloc errorHandlerBloc,
  })  : _homeRepository = homeRepository,
        _errorHandlerBloc = errorHandlerBloc,
        super(const HomeState.initial());

  final HomeRepository _homeRepository;

  final ErrorHandlerBloc _errorHandlerBloc;

  final Set<MealUi> _recipes = {};

  String _query = '';

  int _typeIndex = 0;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeEventInitial) {
      yield* _mapHomeEventInitial(event);
    } else if (event is HomeEventSetQuery) {
      yield* _mapHomeEventSetQuery(event);
    } else if (event is HomeEventSetCategory) {
      yield* _mapHomeEventSetCategory(event);
    }
  }

  Stream<HomeState> _mapHomeEventInitial(HomeEventInitial event) async* {
    try {
      final mealUi = await _homeRepository.searchByQuery(query: _query);

      _recipes.addAll(mealUi);

      yield HomeState.update(
        recipes: _recipes.toList(),
        currentQuery: _query,
        currentType: _typeIndex,
      );
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
      yield const HomeState.error();
    }
  }

  Stream<HomeState> _mapHomeEventSetQuery(HomeEventSetQuery event) async* {
    try {
      _query = event.query;
      _typeIndex = 0;

      final mealUi = await _homeRepository.searchByQuery(query: _query);

      _recipes
        ..clear()
        ..addAll(mealUi);

      yield HomeState.update(
        recipes: _recipes.toList(),
        currentQuery: _query,
        currentType: _typeIndex,
      );
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
      yield const HomeState.error();
    }
  }

  Stream<HomeState> _mapHomeEventSetCategory(
      HomeEventSetCategory event) async* {
    try {
      _typeIndex = event.typeIndex;
      _query = '';

      final type = RecipeType.typeByIndex(_typeIndex);

      List<MealUi> mealUi;

      if (type != null) {
        mealUi = await _homeRepository.searchByCategory(category: type);
      } else {
        mealUi = await _homeRepository.searchByQuery(query: _query);
      }

      _recipes
        ..clear()
        ..addAll(mealUi);

      yield HomeState.update(
        recipes: _recipes.toList(),
        currentQuery: _query,
        currentType: _typeIndex,
      );
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
      yield const HomeState.error();
    }
  }
}
