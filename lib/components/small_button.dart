import 'package:flutter/material.dart';

class SmallWhiteButton extends StatelessWidget {
  const SmallWhiteButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color:Colors.white),
          borderRadius: BorderRadius.circular(29),
        ),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(text,
              style: const TextStyle(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
