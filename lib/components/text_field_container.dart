import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key? key,
    required this.child
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      width: size.width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
      ), child: child
    );
  }
}