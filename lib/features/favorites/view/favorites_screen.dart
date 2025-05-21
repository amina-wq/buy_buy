import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:buy_buy/bloc/product/product_bloc.dart';
import 'package:buy_buy/features/favorites/bloc/favorites_bloc.dart';
import 'package:buy_buy/models/models.dart';
import 'package:buy_buy/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(snap: true, pinned: true, floating: true, centerTitle: true, title: const Text('Favorites')),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              } else if (state is FavoritesLoaded) {
                final favorites = state.favorites;
                if (favorites.isEmpty) {
                  return SliverFillRemaining(child: Center(child: Text('No favorites found. Try adding some!')));
                }

                return SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = favorites[index];
                    return ProductCard(
                      isFavorite: true,
                      product: product,
                      onTap: () => {},
                      onToggleFavorite: () => _onRemoveFavorite(product),
                    );
                  },
                  itemCount: state.favorites.length,
                );
              } else {
                return SliverToBoxAdapter(child: Center(child: Text('No favorites found')));
              }
            },
          ),
        ),
      ],
    );
  }

  void _onRemoveFavorite(Product product) async {
    final favoritesBloc = context.read<FavoritesBloc>();
    final productBloc = context.read<ProductBloc>();

    final completer = Completer();
    favoritesBloc.add(RemoveFavoriteEvent(product: product, completer: completer));
    await completer.future;

    productBloc.add(ProductLoadEvent());
  }
}
