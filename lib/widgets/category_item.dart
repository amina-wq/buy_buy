import 'package:flutter/material.dart';
import '/providers/category_provider.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';

class CategoryItem extends StatefulWidget {
  final int id;
  final String title;
  final IconData iconData;

  const CategoryItem({
    super.key,
    required this.id,
    required this.title,
    required this.iconData,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    int selectedId = context.watch<CategoryProvider>().selectedId;

    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: widget.id == selectedId ? ORANGE : Colors.white,
          ),
          child: IconButton(
            onPressed:
                () => {context.read<CategoryProvider>().setCategory(widget.id)},
            icon: Icon(
              widget.iconData,
              color: widget.id == selectedId ? Colors.white : Colors.grey,
            ),
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            color: widget.id == selectedId ? ORANGE : Colors.black,
          ),
        ),
      ],
    );
  }
}
