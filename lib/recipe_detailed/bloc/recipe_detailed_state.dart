import 'package:equatable/equatable.dart';
import 'package:mealbook/common/models/meal_ui.dart';

enum RecipeDetailedStateStatus { initial, update, error }

class RecipeDetailedState extends Equatable {
  const RecipeDetailedState._({
    required this.status,
    this.mealUi,
  });

  const RecipeDetailedState.initial()
      : this._(status: RecipeDetailedStateStatus.initial);

  const RecipeDetailedState.update({required MealUi mealUi})
      : this._(
          status: RecipeDetailedStateStatus.update,
          mealUi: mealUi,
        );

  const RecipeDetailedState.error()
      : this._(status: RecipeDetailedStateStatus.error);

  final RecipeDetailedStateStatus status;
  final MealUi? mealUi;

  @override
  List<Object?> get props => [status, mealUi];
}
