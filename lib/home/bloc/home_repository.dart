import 'package:mealbook/common/api/api_routes.dart';
import 'package:mealbook/common/api/dio/dio_utils.dart';
import 'package:mealbook/common/models/meal_ui.dart';
import 'package:mealbook/common/models/search_response.dart';

class HomeRepository {
  const HomeRepository(DioUtils dioUtils) : _dioUtils = dioUtils;

  final DioUtils _dioUtils;

  Future<List<MealUi>> searchByQuery({String query = ''}) async {
    final response = await _dioUtils.getQuery<Map<String, dynamic>>(
      ApiRoutes.recipesByQuery,
      queryParameters: <String, dynamic>{'s': query},
    );

    final searchResponse = SearchResponse.fromJson(response.data!);

    final meals = searchResponse.meals ?? [];

    return meals.map((meal) => meal.toUi).toList();
  }

  Future<List<MealUi>> searchByCategory({required String category}) async {
    final response = await _dioUtils.getQuery<Map<String, dynamic>>(
      ApiRoutes.recipesByCategory,
      queryParameters: <String, dynamic>{'c': category},
    );

    final searchResponse = SearchResponse.fromJson(response.data!);

    final meals = searchResponse.meals ?? [];

    return meals.map((meal) => meal.toUi).toList();
  }
}
