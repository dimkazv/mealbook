import 'package:equatable/equatable.dart';
import 'package:mealbook/common/models/meal_ui.dart';

enum HomeStateStatus { initial, update, error }

class HomeState extends Equatable {
  const HomeState._({
    required this.status,
    this.recipes,
    this.currentQuery = '',
    this.currentType = 0,
  });

  const HomeState.initial() : this._(status: HomeStateStatus.initial);

  const HomeState.update({
    required List<MealUi> recipes,
    required String currentQuery,
    required int currentType,
  }) : this._(
          status: HomeStateStatus.update,
          recipes: recipes,
          currentQuery: currentQuery,
          currentType: currentType,
        );

  const HomeState.error() : this._(status: HomeStateStatus.error);

  final HomeStateStatus status;
  final List<MealUi>? recipes;
  final String currentQuery;
  final int currentType;

  @override
  List<Object?> get props => [
        status,
        recipes,
        currentType,
      ];
}
