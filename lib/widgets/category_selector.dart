import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'category_item.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Category",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => {},
              child: Text("view all", style: TextStyle(color: ORANGE)),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: CATEGORIES.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 80,
                width: 100,
                child: CategoryItem(
                  id: CATEGORIES[index]['id'] as int,
                  title: CATEGORIES[index]['title'] as String,
                  iconData: CATEGORIES[index]['icon'] as IconData,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
