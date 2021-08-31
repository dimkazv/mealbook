import 'package:mealbook/common/api/api_routes.dart';
import 'package:mealbook/common/api/dio/dio_utils.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/common/models/search_response.dart';

class RecipeDetailedRepository {
  const RecipeDetailedRepository(DioUtils dioUtils) : _dioUtils = dioUtils;

  final DioUtils _dioUtils;

  Future<MealUi> getById({required int id}) async {
    final response = await _dioUtils.getQuery<Map<String, dynamic>>(
      ApiRoutes.recipesById,
      queryParameters: <String, dynamic>{'i': id},
    );

    final searchResponse = SearchResponse.fromJson(response.data!);

    final meals = searchResponse.meals ?? [];

    return meals
        .map((meal) => MealUi(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              instructions: meal.instructions,
              ingredients: meal.ingredients
                  .where((i) => i != null && i.isNotEmpty)
                  .cast<String>()
                  .toList(),
              measures: meal.measures
                  .where((m) => m != null && m.isNotEmpty)
                  .cast<String>()
                  .toList(),
            ))
        .first;
  }
}
