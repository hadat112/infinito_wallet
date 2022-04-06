import 'package:flutter/material.dart';

class CircleBtn extends StatelessWidget {
  final String title;
  const CircleBtn({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(children: [
        CircleAvatar(
          radius: 31,
          backgroundColor: const Color(0xFFC4C4C4),
        ),
        Container(
            width: 100,
            child: Align(alignment: Alignment.center, child: Text(title))),
      ]),
    );
  }
}
