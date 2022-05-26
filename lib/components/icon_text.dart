import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconText extends StatefulWidget {
  const IconText({
    Key? key,
    required this.text, required this.icon, required this.tap, this.color,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color? color;
  final void Function() tap;

  @override
  State<IconText> createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  double _opacity = 1;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 100),
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
        child: Column(
          children: [    
            Icon(widget.icon, size: 36.sp, color: widget.color,),
            Text(
              widget.text,
              style: TextStyle(
                color: widget.color,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}