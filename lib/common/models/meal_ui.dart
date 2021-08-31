import 'package:equatable/equatable.dart';

class MealUi extends Equatable {
  const MealUi({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
    required this.measures,
  });

  final int id;

  final String title;

  final String imageUrl;

  final String? instructions;

  final List<String>? ingredients;

  final List<String>? measures;

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        instructions,
        ingredients,
        measures,
      ];
}
