import 'package:flutter/material.dart';

import '../Screens/SettingWallet/setting_wallet.dart';
import 'circle_icon.dart';

class LineBtn extends StatefulWidget {
 const LineBtn({
    Key? key,
    required this.title,
    required this.tap,
  }) : super(key: key);

  final String title;
  final void Function() tap;

  @override
  State<LineBtn> createState() => _LineBtnState();
}

class _LineBtnState extends State<LineBtn> {
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: _opacity,
      child: GestureDetector(
      onTap: widget.tap,
      onTapDown: (TapDownDetails details) {
            setState(() {
              _opacity = 0.3;
            });
          },
          onTapUp: (TapUpDetails details) {
            setState(() {
              _opacity = 1;
            });
          },
          onTapCancel: (){
            setState(() {
              _opacity = 1;
            });
          },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4)),
        )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.arrow_forward_ios)
        ]),
      ),
    ),
    );
  }
}