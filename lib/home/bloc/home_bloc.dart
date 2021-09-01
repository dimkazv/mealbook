import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/home/bloc/home_event.dart';
import 'package:mealbook/home/bloc/home_repository.dart';
import 'package:mealbook/home/bloc/home_state.dart';
import 'package:mealbook/home/models/recipe_category.dart';

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

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeInitial) {
      yield* _mapHomeInitial(event);
    } else if (event is HomeFetchedByQuery) {
      yield* _mapHomeFetchedByQuery(event);
    } else if (event is HomeFetchedByCategory) {
      yield* _mapHomeFetchedByCategory(event);
    }
  }

  Stream<HomeState> _mapHomeInitial(HomeInitial event) async* {
    try {
      final mealUi = await _homeRepository.searchByQuery();

      _recipes.addAll(mealUi);

      yield HomeState.update(recipes: _recipes.toList());
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
      yield const HomeState.error();
    }
  }

  Stream<HomeState> _mapHomeFetchedByQuery(HomeFetchedByQuery event) async* {
    try {
      final mealUi = await _homeRepository.searchByQuery(query: event.query);

      _recipes
        ..clear()
        ..addAll(mealUi);

      yield HomeState.update(
        recipes: _recipes.toList(),
        currentQuery: event.query,
      );
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
      yield const HomeState.error();
    }
  }

  Stream<HomeState> _mapHomeFetchedByCategory(
    HomeFetchedByCategory event,
  ) async* {
    try {
      List<MealUi> mealUi;

      if (event.category != RecipeCategoryEnum.any) {
        final category = RecipeCategoryHelper.getName(event.category);
        mealUi = await _homeRepository.searchByCategory(category: category);
      } else {
        mealUi = await _homeRepository.searchByQuery();
      }

      _recipes
        ..clear()
        ..addAll(mealUi);

      yield HomeState.update(
        recipes: _recipes.toList(),
        category: event.category,
      );
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
      yield const HomeState.error();
    }
  }
}
