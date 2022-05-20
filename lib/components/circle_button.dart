import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 24),
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
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 16,
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
