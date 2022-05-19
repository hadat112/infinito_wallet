import 'package:flutter/material.dart';

import '../Screens/ChangeName/change_name.dart';


class SettingBtn extends StatefulWidget {
  const SettingBtn({
    Key? key,
    this.text = '',
    required this.icon,
  }) : super(key: key);

  final String text;
  final Icon icon;

  @override
  State<SettingBtn> createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingBtn> {
  double _opacity = 1;
  String getInitials({String? string, int? limitTo}) {
    final buffer = StringBuffer();
    final split = string?.split(' ');
    for (var i = 0; i < (limitTo ?? split!.length); i++) {
      buffer.write(split?[i][0]);
    }
    return buffer.toString().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: _opacity,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute<dynamic>(builder: (context) {
            return ChangeName();
          }));
        },
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
        onTapCancel: () {
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
            Row(
              children: [
                widget.icon,
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios)
          ]),
        ),
      ),
    );
  }
}
