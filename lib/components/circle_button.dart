import 'package:flutter/material.dart';

class CircleBtn extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: GestureDetector(
        onTap: tap,
        child: Column(
          children: [
            Image.asset(
              path,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
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
      ),
    );
  }
}
