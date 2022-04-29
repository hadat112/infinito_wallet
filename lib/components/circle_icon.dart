import 'package:flutter/material.dart';

class IconCircle extends StatelessWidget {
  const IconCircle({
    Key? key, required this.circleSize, required this.textInside, this.textSize = 22,
  }) : super(key: key);
  final double circleSize;
  final double textSize;
  final String textInside;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleSize,
      width: circleSize,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(90, 195, 240, 1),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40)),
      ),
      child: Center(child: Text(textInside,
        style: TextStyle(
          color: Colors.white,
          fontSize: textSize,
          fontWeight: FontWeight.w400
        ),
      )),
    );
  }
}
