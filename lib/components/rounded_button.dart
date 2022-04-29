import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.text = '',
    this.color = const Color.fromRGBO(90, 195, 240, 1),
    this.textColor = Colors.white,
    required this.press, this.btnWidth = 260, this.btnHeight=55,
  }) : super(key: key);

  final String text;
  final Color color, textColor;
  final double btnWidth;
  final double btnHeight;

  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: btnHeight,
      width: btnWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: color,
          onPressed: press, 
          child: Text(
            text,
            style: TextStyle(color: textColor),
          )
        ),
      ),
    );
  }
}