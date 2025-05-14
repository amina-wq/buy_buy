import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:buy_buy/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
      routes: const [
        ExplorerRoute(),
        CartRoute(),
        FavoritesRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: theme.hintColor,
            unselectedItemColor: theme.scaffoldBackgroundColor,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => _openPage(index, tabsRouter),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.search_outlined),
                label: 'Explorer',
                backgroundColor: theme.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Cart',
                backgroundColor: theme.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Favorites',
                backgroundColor: theme.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
                backgroundColor: theme.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}
