import 'dart:ffi';

import 'package:flutter/material.dart';

class CircleBtn extends StatelessWidget {
  final String title;
  final void Function() tap;
  const CircleBtn({
    Key? key,
    required this.title, required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        GestureDetector(
          onTap: tap,
          child: CircleAvatar(
            radius: 31,
            backgroundColor: const Color(0xFFC4C4C4),
          ),
        ),
        SizedBox(height: 5,),
        Text(title,
        textAlign: TextAlign.center,),
      ]),
    );
  }
}
