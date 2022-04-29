import 'package:flutter/material.dart';

import 'circle_icon.dart';

class WalletInfo extends StatelessWidget {
  const WalletInfo({
    Key? key,
    required this.size, required this.walletName, required this.walletAdd,
  }) : super(key: key);

  final String walletName;
  final String walletAdd;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Ví',
                  style: TextStyle(
                     color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 18, fontWeight: FontWeight.w600))),
        ),
        Card(
          color: const Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29),
          ),
          child: Container(
            height: 60,
            width: size.width * 0.9,
            // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const IconCircle(textInside: 'IW', circleSize: 60,),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      walletName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      walletAdd,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(7, 15, 87, 1)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

