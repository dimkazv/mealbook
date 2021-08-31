import 'package:equatable/equatable.dart';

abstract class RecipeDetailedEvent extends Equatable {
  const RecipeDetailedEvent();

  @override
  List<Object> get props => [];
}

class RecipeDetailedEventInitial extends RecipeDetailedEvent {
  const RecipeDetailedEventInitial({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
