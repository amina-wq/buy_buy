part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

final class FavoritesLoadEvent extends FavoritesEvent {}

final class RemoveFavoriteEvent extends FavoritesEvent {
  const RemoveFavoriteEvent({required this.product, this.completer});

  final Product product;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([product, completer]);
}
