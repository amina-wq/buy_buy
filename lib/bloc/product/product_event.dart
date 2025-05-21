part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class ProductLoadEvent extends ProductEvent {
  const ProductLoadEvent({this.categoryId});

  final String? categoryId;

  @override
  List<Object?> get props => super.props..add(categoryId);
}

final class ToggleFavoriteProductEvent extends ProductEvent {
  const ToggleFavoriteProductEvent({required this.productId, this.completer});

  final String productId;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([productId, completer]);
}
