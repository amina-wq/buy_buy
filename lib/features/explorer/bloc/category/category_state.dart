part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  CategoryLoaded({
    required this.categories,
    Category? selectedCategory,
  }) : category = selectedCategory ?? categories.first;

  final List<Category> categories;
  final Category? category;

  @override
  List<Object> get props => super.props..add([categories, category]);
}

final class CategoryFailure extends CategoryState {
  const CategoryFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
