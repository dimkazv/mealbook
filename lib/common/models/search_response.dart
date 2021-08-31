import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mealbook/common/models/meal_response.dart';

part 'search_response.g.dart';

@JsonSerializable(createToJson: false)
class SearchResponse extends Equatable {
  const SearchResponse(this.meals);

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  final List<MealResponse>? meals;

  @override
  List<Object?> get props => [meals];
}
