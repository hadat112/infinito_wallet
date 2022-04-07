import 'package:flutter/material.dart';

class WalletInfo extends StatelessWidget {
  final String walletName;
  final String walletAdd;
  const WalletInfo({
    Key? key,
    required this.size, required this.walletName, required this.walletAdd,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Ví',
                  style: TextStyle(
                     color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 18, fontWeight: FontWeight.w600))),
        ),
        Card(
          color: Color(0xFFF4F4F4),
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
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(90, 195, 240, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                  ),
                  child: Center(child: Text("PW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400
                    ),
                  )),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      walletName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      walletAdd,
                      style: TextStyle(
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