import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    required this.text, required this.icon, required this.tap,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final void Function() tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        children: [    
          Icon(icon, size: 36, color: const Color.fromRGBO(0, 0, 0, 0.8),),
          Text(
            text,
            style: const TextStyle(
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