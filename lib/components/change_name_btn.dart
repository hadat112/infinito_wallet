import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingBtn extends StatefulWidget {
  const SettingBtn({
    Key? key,
    this.text = '',
    required this.icon, required this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final void Function() press;


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
        onTap: widget.press,
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
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
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
                  style:  TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, 
            size: 20.sp,)
          ]),
        ),
      ),
    );
  }
}
