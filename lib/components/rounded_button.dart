import 'package:flutter/material.dart';

import '../Screens/login/LoginPage.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final String btnSize;
  final void Function() press;
  const RoundedButton({
    Key? key,
    this.text = "",
    this.color = const Color.fromRGBO(90, 195, 240, 1),
    this.textColor = Colors.white,
    required this.press, this.btnSize="M"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: btnSize == "M" ? size.width * 0.7 : size.width * 0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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