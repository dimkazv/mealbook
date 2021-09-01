import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_bloc.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_event.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_repository.dart';
import 'package:mealbook/recipe_detailed/bloc/recipe_detailed_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recipe_detailed_bloc_test.mocks.dart';

@GenerateMocks([
  ErrorHandlerBloc,
  RecipeDetailedRepository,
])
void main() {
  group('RecipeDetailedBloc', () {
    late RecipeDetailedBloc recipeDetailedBloc;

    final errorHandlerBloc = MockErrorHandlerBloc();
    late RecipeDetailedRepository recipeDetailedRepository;

    const mealUi = MealUi(
      id: '1',
      title: 'title',
      imageUrl: 'imageUrl',
      instructions: 'instructions',
      ingredients: ['ingredients'],
      measures: ['measures'],
    );

    setUp(() {
      recipeDetailedRepository = MockRecipeDetailedRepository();

      recipeDetailedBloc = RecipeDetailedBloc(
        errorHandlerBloc: errorHandlerBloc,
        recipeDetailedRepository: recipeDetailedRepository,
      );
    });

    test('initial state is RecipeDetailedState.initial', () {
      expect(recipeDetailedBloc.state, const RecipeDetailedState.initial());
    });

    group('RecipeDetailedEventSetQuery', () {
      blocTest<RecipeDetailedBloc, RecipeDetailedState>(
        'Return RecipeDetailedState.update when RecipeDetailedEventSetQuery if success',
        build: () {
          when(recipeDetailedRepository.getById(id: '1'))
              .thenAnswer((_) async => mealUi);

          return recipeDetailedBloc;
        },
        act: (bloc) => recipeDetailedBloc.add(
          const RecipeDetailedEventInitial(id: '1'),
        ),
        expect: () => [const RecipeDetailedState.update(mealUi: mealUi)],
      );

      blocTest<RecipeDetailedBloc, RecipeDetailedState>(
        'Return RecipeDetailedState.error when RecipeDetailedEventSetQuery if exception',
        build: () {
          when(recipeDetailedRepository.getById(id: '1'))
              .thenThrow(Exception());

          return recipeDetailedBloc;
        },
        act: (bloc) => recipeDetailedBloc.add(
          const RecipeDetailedEventInitial(id: '1'),
        ),
        expect: () => [const RecipeDetailedState.error()],
        verify: (bloc) => verify<void>(errorHandlerBloc.add(any)).called(1),
      );
    });
  });
}
