import 'package:flutter/material.dart';
import '/providers/category_provider.dart';
import '/widgets/category_selector.dart';
import '/widgets/hot_sales_block.dart';
import '/widgets/main_header.dart';
import '/widgets/search_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'MarkPro'),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                spacing: 10,
                children: [
                  MainHeader(),
                  CategorySelector(),
                  CustomSearchBar(),
                  HotSalesBlock(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
