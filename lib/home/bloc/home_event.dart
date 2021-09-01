import 'package:equatable/equatable.dart';
import 'package:mealbook/home/models/recipe_category.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeEvent {}

class HomeFetchedByQuery extends HomeEvent {
  const HomeFetchedByQuery({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class HomeFetchedByCategory extends HomeEvent {
  const HomeFetchedByCategory({required this.category});

  final RecipeCategoryEnum category;

  @override
  List<Object> get props => [category];
}
