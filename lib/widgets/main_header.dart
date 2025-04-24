import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(),
        Row(
          children: [
            Icon(Icons.room_outlined),
            Text("Zihutanejo, Gro"),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
        IconButton(onPressed: () => {}, icon: Icon(Icons.filter_list_alt)),
      ],
    );
  }
}
