import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  const WhiteButton({
    Key? key,
    this.text = '',
    this.color = const Color.fromRGBO(90, 195, 240, 1),
    this.textColor = Colors.white,
    required this.press,
    this.btnWidth = 260,
    this.btnHeight = 55,
  }) : super(key: key);

  final String text;
  final double btnWidth;
  final double btnHeight;
  final void Function() press;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: btnWidth,
      height: btnHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            onPressed: press,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Colors.blue),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(text,
                style: TextStyle(
                  color: textColor,
                )),
            ),
      ),
    );
  }
}
