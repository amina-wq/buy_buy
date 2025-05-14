import 'package:buy_buy/models/models.dart';
import 'package:buy_buy/repositories/category/category_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required CategoryRepositoryInterface categoryRepository})
    : _categoryRepository = categoryRepository,
      super(CategoryInitial()) {
    on<CategoryLoadEvent>(_onLoad);
    on<SwitchCategoryEvent>(_onSwitch);
  }

  final CategoryRepositoryInterface _categoryRepository;

  _onLoad(CategoryLoadEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await _categoryRepository.getAllCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryFailure(error: e));
    }
  }

  _onSwitch(SwitchCategoryEvent event, Emitter<CategoryState> emit) {
    if (state is CategoryLoaded) {
      emit(
        CategoryLoaded(
          categories: (state as CategoryLoaded).categories,
          selectedCategory: event.category,
        ),
      );
    }
  }
}
