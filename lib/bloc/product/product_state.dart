part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  const ProductLoaded({required this.products, required this.favoriteIds});

  final List<Product> products;
  final List<String> favoriteIds;

  @override
  List<Object> get props => super.props..addAll([products, favoriteIds]);

  ProductLoaded copyWith({List<Product>? products, List<String>? favoriteIds}) {
    return ProductLoaded(products: products ?? this.products, favoriteIds: favoriteIds ?? this.favoriteIds);
  }
}

final class ProductFailure extends ProductState {
  const ProductFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
