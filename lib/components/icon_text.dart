import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() tap;
  const IconText({
    Key? key,
    required this.text, required this.icon, required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        children: [    
          Icon(icon, size: 36, color: Color.fromRGBO(0, 0, 0, 0.8),),
          Text(
            text,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}