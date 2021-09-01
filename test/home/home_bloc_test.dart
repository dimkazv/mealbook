import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealbook/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/home/bloc/home_bloc.dart';
import 'package:mealbook/home/bloc/home_event.dart';
import 'package:mealbook/home/bloc/home_repository.dart';
import 'package:mealbook/home/bloc/home_state.dart';
import 'package:mealbook/home/models/recipe_category.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([
  ErrorHandlerBloc,
  HomeRepository,
])
void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;

    final errorHandlerBloc = MockErrorHandlerBloc();
    late HomeRepository homeRepository;

    const mealUi1 = MealUi(
      id: '1',
      title: 'title',
      imageUrl: 'imageUrl',
      instructions: 'instructions',
      ingredients: ['ingredients'],
      measures: ['measures'],
    );

    const mealUi2 = MealUi(
      id: '2',
      title: 'title',
      imageUrl: 'imageUrl',
      instructions: 'instructions',
      ingredients: ['ingredients'],
      measures: ['measures'],
    );

    const mealUiList1 = <MealUi>[mealUi1, mealUi2];

    const mealUiList2 = <MealUi>[mealUi1];

    setUp(() {
      homeRepository = MockHomeRepository();

      homeBloc = HomeBloc(
        errorHandlerBloc: errorHandlerBloc,
        homeRepository: homeRepository,
      );
    });

    test('initial state is HomeState.initial', () {
      expect(homeBloc.state, const HomeState.initial());
    });

    group('HomeFetchedByQuery', () {
      blocTest<HomeBloc, HomeState>(
        'Return HomeState.update when HomeFetchedByQuery if success',
        build: () {
          when(homeRepository.searchByQuery())
              .thenAnswer((_) async => mealUiList1);

          when(homeRepository.searchByQuery(query: 'query'))
              .thenAnswer((_) async => mealUiList2);
          return homeBloc;
        },
        act: (bloc) {
          homeBloc
            ..add(HomeInitial())
            ..add(const HomeFetchedByQuery(query: 'query'));
        },
        expect: () => [
          const HomeState.update(recipes: mealUiList1),
          const HomeState.update(currentQuery: 'query', recipes: mealUiList2),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'Return HomeState.error when HomeFetchedByQuery if exception',
        build: () {
          when(homeRepository.searchByQuery())
              .thenAnswer((_) async => mealUiList1);
          when(homeRepository.searchByQuery(query: 'query'))
              .thenThrow(Exception());

          return homeBloc;
        },
        act: (bloc) => homeBloc
          ..add(HomeInitial())
          ..add(const HomeFetchedByQuery(query: 'query')),
        expect: () => [
          const HomeState.update(recipes: mealUiList1),
          const HomeState.error(),
        ],
        verify: (bloc) => verify<void>(errorHandlerBloc.add(any)).called(1),
      );
    });

    group('HomeFetchedByCategory', () {
      blocTest<HomeBloc, HomeState>(
        'Return HomeState.update when HomeFetchedByCategory if success',
        build: () {
          when(homeRepository.searchByQuery())
              .thenAnswer((_) async => mealUiList1);
          when(homeRepository.searchByCategory(
            category: RecipeCategoryHelper.getName(RecipeCategoryEnum.beef),
          )).thenAnswer((_) async => mealUiList2);
          return homeBloc;
        },
        act: (bloc) => homeBloc
          ..add(HomeInitial())
          ..add(const HomeFetchedByCategory(category: RecipeCategoryEnum.beef)),
        expect: () => [
          const HomeState.update(recipes: mealUiList1),
          const HomeState.update(
            category: RecipeCategoryEnum.beef,
            recipes: mealUiList2,
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'Return HomeState.error when HomeFetchedByCategory if exception',
        build: () {
          when(homeRepository.searchByQuery())
              .thenAnswer((_) async => mealUiList1);
          when(homeRepository.searchByCategory(
            category: RecipeCategoryHelper.getName(RecipeCategoryEnum.beef),
          )).thenThrow(Exception());

          return homeBloc;
        },
        act: (bloc) => homeBloc
          ..add(HomeInitial())
          ..add(
            const HomeFetchedByCategory(category: RecipeCategoryEnum.beef),
          ),
        expect: () => [
          const HomeState.update(recipes: mealUiList1),
          const HomeState.error(),
        ],
        verify: (bloc) => verify<void>(errorHandlerBloc.add(any)).called(1),
      );
    });
  });
}
