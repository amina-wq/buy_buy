import 'package:buy_buy/features/auth/auth.dart';
import 'package:buy_buy/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onToggleFavorite,
    this.isFavorite = false,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: theme.shadowColor.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) => const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                  if (!product.isBrandNew)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: theme.highlightColor, borderRadius: BorderRadius.circular(8)),
                        child: Text('SH', style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      if (authState is Authorized) {
                        return Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: onToggleFavorite,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                size: 16,
                                color: isFavorite ? theme.primaryColor : theme.hintColor,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    'RM ${product.price.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(product.name, style: theme.textTheme.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (product.characteristics?.isNotEmpty == true)
                    Text(
                      product.characteristics!,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
