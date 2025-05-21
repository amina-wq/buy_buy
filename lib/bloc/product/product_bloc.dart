import 'dart:async';

import 'package:buy_buy/models/models.dart';
import 'package:buy_buy/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required ProductRepositoryInterface productRepository,
    required FavoriteRepositoryInterface favoriteRepository,
  }) : _productRepository = productRepository,
       _favoriteRepository = favoriteRepository,
       super(ProductInitial()) {
    on<ProductLoadEvent>(_onLoad);
    on<ToggleFavoriteProductEvent>(_onToggleFavorite);
  }

  final ProductRepositoryInterface _productRepository;
  final FavoriteRepositoryInterface _favoriteRepository;

  _onLoad(ProductLoadEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProducts(categoryId: event.categoryId);
      final favoriteIds = await _favoriteRepository.getFavoriteIds();
      emit(ProductLoaded(products: products, favoriteIds: favoriteIds));
    } catch (e) {
      emit(ProductFailure(error: e));
    }
  }

  _onToggleFavorite(ToggleFavoriteProductEvent event, Emitter<ProductState> emit) async {
    final previousState = state;
    if (previousState is! ProductLoaded) return;
    try {
      await _favoriteRepository.toggleFavorite(event.productId);
      final favoritesIds = await _favoriteRepository.getFavoriteIds();
      emit(previousState.copyWith(favoriteIds: favoritesIds));
    } catch (e) {
      emit(ProductFailure(error: e));
    } finally {
      event.completer?.complete();
    }
  }
}
