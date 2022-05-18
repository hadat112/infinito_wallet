import 'package:flutter/material.dart';

class SmallWhiteButton extends StatelessWidget {
  const SmallWhiteButton({
    Key? key,
    this.text = '',
    this.color = Colors.white,
    this.textColor = Colors.white,
    required this.press,
    this.btnWidth = 75,
    this.btnHeight = 18,
  }) : super(key: key);

  final String text;
  final double btnWidth;
  final double btnHeight;
  final void Function() press;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: btnWidth,
      height: btnHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FlatButton(
            onPressed: press,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(text,
                style: TextStyle(
                  fontSize: 8,
                  color: textColor,
                )),
            ),
      ),
    );
  }
}