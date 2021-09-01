import 'package:equatable/equatable.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/home/models/recipe_category.dart';

enum HomeStateStatus { initial, update, error }

class HomeState extends Equatable {
  const HomeState._({
    required this.status,
    this.recipes,
    this.currentQuery = '',
    this.category = RecipeCategoryEnum.any,
  });

  const HomeState.initial() : this._(status: HomeStateStatus.initial);

  const HomeState.update({
    required List<MealUi> recipes,
    RecipeCategoryEnum category = RecipeCategoryEnum.any,
    String currentQuery = '',
  }) : this._(
          status: HomeStateStatus.update,
          recipes: recipes,
          currentQuery: currentQuery,
          category: category,
        );

  const HomeState.error() : this._(status: HomeStateStatus.error);

  final HomeStateStatus status;
  final List<MealUi>? recipes;
  final String currentQuery;
  final RecipeCategoryEnum category;

  @override
  List<Object?> get props => [
        status,
        recipes,
        currentQuery,
        category,
      ];
}
