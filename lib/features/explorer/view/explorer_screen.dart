import 'package:auto_route/auto_route.dart';
import 'package:buy_buy/features/explorer/bloc/category/category_bloc.dart';
import 'package:buy_buy/features/explorer/explorer.dart';
import 'package:buy_buy/models/category/category.dart';
import 'package:buy_buy/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ExplorerScreen extends StatefulWidget {
  const ExplorerScreen({super.key});

  @override
  State<ExplorerScreen> createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          centerTitle: true,
          title: GestureDetector(
            onTap: () => {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.room_outlined, color: theme.hintColor, size: 16),
                Text("Zihutanejo, Gro", style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                Icon(Icons.keyboard_arrow_down, size: 16),
              ],
            ),
          ),
          actions: [IconButton(onPressed: () => {}, icon: Icon(Icons.filter_alt_outlined, size: 24))],
        ),
        SliverPadding(
          padding: EdgeInsets.all(16).copyWith(top: 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Category', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                    TextButton(
                      onPressed: () async {
                        final categoryBloc = context.read<CategoryBloc>();
                        var category = await context.pushRoute<Category>(CategoriesRoute());
                        if (category != null) {
                          categoryBloc.add(SwitchCategoryEvent(category: category));
                        }
                      },
                      child: Text('view all', style: TextStyle(color: theme.hintColor)),
                    ),
                  ],
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CategoryLoaded) {
                      return SizedBox(
                        height: 72,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryButton(
                              onTap: () => _onSwitchCategory(context, state.categories, index),
                              category: state.categories[index],
                              isSelected: state.categories[index] == state.category,
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(width: 16),
                          itemCount: state.categories.length,
                        ),
                      );
                    } else {
                      return Center(child: Text('Error loading categories'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSwitchCategory(BuildContext context, List categories, int index) {
    context.read<CategoryBloc>().add(SwitchCategoryEvent(category: categories[index]));
  }
}
