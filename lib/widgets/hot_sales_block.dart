import 'package:flutter/material.dart';
import '/core/constants.dart';

class HotSalesBlock extends StatefulWidget {
  const HotSalesBlock({super.key});

  @override
  State<HotSalesBlock> createState() => _HotSalesBlockState();
}

class _HotSalesBlockState extends State<HotSalesBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hot Sales",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => {},
              child: Text("see more", style: TextStyle(color: ORANGE)),
            ),
          ],
        ),
        // Expanded(
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (BuildContext context, index) {
        //       return SizedBox(
        //         width: 75,
        //         child: HotSalesItem(
        //
        //           // imageData: Image(image: )),
        //         ),
        //       );
        //     },
        //     itemCount: CATEGORIES.length,
        //   ),
        // )
      ],
    );
  }
}
