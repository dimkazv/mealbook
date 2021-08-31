import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_event.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_repository.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_state.dart';

class RecipeDetailedBloc
    extends Bloc<RecipeDetailedEvent, RecipeDetailedState> {
  RecipeDetailedBloc({
    required RecipeDetailedRepository recipeDetailedRepository,
    required ErrorHandlerBloc errorHandlerBloc,
  })  : _recipeDetailedRepository = recipeDetailedRepository,
        _errorHandlerBloc = errorHandlerBloc,
        super(const RecipeDetailedState.initial());

  final RecipeDetailedRepository _recipeDetailedRepository;
  final ErrorHandlerBloc _errorHandlerBloc;

  @override
  Stream<RecipeDetailedState> mapEventToState(
    RecipeDetailedEvent event,
  ) async* {
    if (event is RecipeDetailedEventInitial) {
      yield* _mapRecipeDetailedEventInitial(event);
    }
  }

  Stream<RecipeDetailedState> _mapRecipeDetailedEventInitial(
      RecipeDetailedEventInitial event) async* {
    try {
      final mealUi = await _recipeDetailedRepository.getById(id: event.id);

      yield RecipeDetailedState.update(mealUi: mealUi);
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
      yield const RecipeDetailedState.error();
    }
  }
}
