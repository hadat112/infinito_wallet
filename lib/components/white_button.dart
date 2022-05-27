// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class WhiteButton extends StatelessWidget {
  WhiteButton(
      {Key? key,
      this.text = '',
      this.color = const Color.fromRGBO(90, 195, 240, 1),
      this.textColor = Colors.white,
      required this.press,
      this.singleBtn = true})
      : super(key: key);

  final String text;
  bool singleBtn;
  late double btnWidth;
  final void Function() press;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    if (singleBtn) {
      btnWidth =
          MediaQuery.of(context).size.width * 0.7; // width = 25% of the screen
    } else {
      btnWidth =
          MediaQuery.of(context).size.width * 0.44; // width = 25% of the screen
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: btnWidth,
      height: MediaQuery.of(context).size.height * 0.07,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          onPressed: press,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(50),
          ),
          child:
              Text(text, style: TextStyle(color: textColor, fontSize: 16.sp)),
        ),
      ),
    );
  }
}
