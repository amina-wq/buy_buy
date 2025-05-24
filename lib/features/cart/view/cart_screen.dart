import 'package:auto_route/auto_route.dart';
import 'package:buy_buy/bloc/cart/cart_bloc.dart';
import 'package:buy_buy/features/auth/bloc/auth_bloc.dart';
import 'package:buy_buy/features/cart/widgets/cart_item_list_tile.dart';
import 'package:buy_buy/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(CartLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
  listener: _handleAuthState,
  child: BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(pinned: true, floating: true, snap: true, centerTitle: true, title: const Text('My Cart')),
            if (state is CartLoading) ...[
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            ] else if (state is CartLoaded) ...[
              if (state.cartItems.isEmpty)
                const SliverFillRemaining(child: Center(child: Text('Your cart is empty')))
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final detail = state.cartItems[index];
                      return CartItemListTile(
                        cartItem: detail,
                        onAdd: () => _onAddToCart(detail.product),
                        onRemove: () => _onRemoveFromCart(detail.product),
                      );
                    }, childCount: state.cartItems.length),
                  ),
                ),
            ] else ...[
              SliverFillRemaining(child: Center(child: Text('Unable to load cart'))),
            ],
          ],
        );
      },
    ),
);
  }

  _handleAuthState(BuildContext context, AuthState state) {
    if (state is Authorized) {
      context.read<CartBloc>().add(CartLoadEvent());
    }
  }

  _onAddToCart(Product product) {
    context.read<CartBloc>().add(AddToCartEvent(product: product));
  }

  _onRemoveFromCart(Product product) {
    context.read<CartBloc>().add(DeleteFromCartEvent(product: product));
  }
}
