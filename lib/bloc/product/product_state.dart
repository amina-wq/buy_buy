part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  const ProductLoaded({required this.products});

  final List<Product> products;

  @override
  List<Object> get props => super.props..addAll(products);
}

final class ProductFailure extends ProductState {
  const ProductFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
