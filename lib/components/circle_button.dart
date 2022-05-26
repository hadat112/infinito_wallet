import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleBtn extends StatefulWidget {
  const CircleBtn({
    Key? key,
    required this.text,
    required this.tap,
    required this.path,
  }) : super(key: key);
  final String text;
  final String path;

  final void Function() tap;

  @override
  State<CircleBtn> createState() => _CircleBtnState();
}

class _CircleBtnState extends State<CircleBtn> {
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {

    return AnimatedOpacity(
      
      duration: const Duration(milliseconds: 100),
      opacity: _opacity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
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
          onTapCancel: () {
            setState(() {
              _opacity = 1;
            });
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                  
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
                child: Image.asset(
                  widget.path,
                  width: 44.h,
                  height: 44.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
