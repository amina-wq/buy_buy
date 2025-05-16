import 'package:buy_buy/models/models.dart';
import 'package:buy_buy/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepositoryInterface productRepository})
    : _productRepository = productRepository,
      super(ProductInitial()) {
    on<ProductLoadEvent>(_onLoad);
  }

  final ProductRepositoryInterface _productRepository;

  _onLoad(ProductLoadEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProducts(event.categoryId);
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductFailure(error: e));
    }
  }
}
