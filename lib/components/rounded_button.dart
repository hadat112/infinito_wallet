// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class RoundedButton extends StatelessWidget {
  RoundedButton(
      {Key? key,
      this.text = '',
      this.color = const Color.fromRGBO(90, 195, 240, 1),
      this.textColor = Colors.white,
      required this.press,
      this.singleBtn = true})
      : super(key: key);

  final String text;
  final bool singleBtn;
  final Color color, textColor;
  late double btnWidth;

  final void Function() press;

  @override
  Widget build(BuildContext context) {
    if (singleBtn) {
      btnWidth =
          MediaQuery.of(context).size.width * 0.7; // width = 25% of the screen
    } else {
      btnWidth =
          MediaQuery.of(context).size.width * 0.45; // width = 25% of the screen
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.height * 0.07,
      width: btnWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FlatButton(
            key: key,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: color,
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16.sp),
            )),
      ),
    );
  }
}
