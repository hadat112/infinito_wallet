import 'package:flutter/material.dart';

class SmallWhiteButton extends StatelessWidget {
  final String text;
  final void Function() press;
  const SmallWhiteButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
      height: 20,
      child: FlatButton(
          onPressed: press,
          child: Text(text,
              style: TextStyle(
                color: Colors.white,
              )),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(50),
          )),
    );
  }
}