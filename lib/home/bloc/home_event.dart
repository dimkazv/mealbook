import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventInitial extends HomeEvent {}

class HomeEventSetQuery extends HomeEvent {
  const HomeEventSetQuery({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class HomeEventSetCategory extends HomeEvent {
  const HomeEventSetCategory({required this.typeIndex});

  final int typeIndex;

  @override
  List<Object> get props => [typeIndex];
}
