import 'package:flutter/material.dart';

import '../core/constants.dart';


class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 40, // You can tweak this value
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SearchBar(
                leading: const Icon(Icons.search, size: 20),
                hintText: 'Search',
                shadowColor: WidgetStateProperty.all(Colors.black),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: ORANGE,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 20,
                onPressed: () {},
                icon: const Icon(Icons.qr_code),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
