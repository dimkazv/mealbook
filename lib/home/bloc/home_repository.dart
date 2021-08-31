import 'package:mealbook/common/api/api_routes.dart';
import 'package:mealbook/common/api/dio/dio_utils.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/common/models/search_response.dart';

class HomeRepository {
  const HomeRepository(DioUtils dioUtils) : _dioUtils = dioUtils;

  final DioUtils _dioUtils;

  Future<List<MealUi>> searchByQuery({required String query}) async {
    final response = await _dioUtils.getQuery<Map<String, dynamic>>(
      ApiRoutes.recipesByQuery,
      queryParameters: <String, dynamic>{'s': query},
    );

    final searchResponse = SearchResponse.fromJson(response.data!);

    final meals = searchResponse.meals ?? [];

    return meals
        .map((meal) => MealUi(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              category: meal.category,
              area: meal.area,
              instructions: meal.instructions,
              videoLink: meal.videoLink,
              ingredients: meal.ingredients
                  .where((i) => i != null && i.isNotEmpty)
                  .cast<String>()
                  .toList(),
              measures: meal.measures
                  .where((m) => m != null && m.isNotEmpty)
                  .cast<String>()
                  .toList(),
            ))
        .toList();
  }

  Future<List<MealUi>> searchByCategory({required String category}) async {
    final response = await _dioUtils.getQuery<Map<String, dynamic>>(
      ApiRoutes.recipesByCategory,
      queryParameters: <String, dynamic>{'c': category},
    );

    final searchResponse = SearchResponse.fromJson(response.data!);

    final meals = searchResponse.meals ?? [];

    return meals
        .map((meal) => MealUi(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              category: meal.category,
              area: meal.area,
              instructions: meal.instructions,
              videoLink: meal.videoLink,
              ingredients: meal.ingredients
                  .where((i) => i != null && i.isNotEmpty)
                  .cast<String>()
                  .toList(),
              measures: meal.measures
                  .where((m) => m != null && m.isNotEmpty)
                  .cast<String>()
                  .toList(),
            ))
        .toList();
  }
}
