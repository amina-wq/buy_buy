part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class CategoryLoadEvent extends CategoryEvent {}

final class SwitchCategoryEvent extends CategoryEvent {
  const SwitchCategoryEvent({required this.category});

  final Category category;

  @override
  List<Object> get props => super.props..add(category);
}
