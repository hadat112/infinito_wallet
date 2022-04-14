import 'package:flutter/material.dart';

class SendCoinAppBar extends StatelessWidget with PreferredSizeWidget {
  const SendCoinAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color.fromRGBO(7, 15, 87, 1),
                Color.fromRGBO(80, 178, 200, 1)
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              child: Row(children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                  ),
                  child: Center(
                      child: Text(
                    "IW",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Infinito Wallet',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ),
            Card(
              color: Color.fromRGBO(71, 145, 176, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29),
              ),
              child: Container(
                height: 37,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(90, 195, 240, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      child: Center(
                          child: Text(
                        "PW",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '0.321898',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    SizedBox(width: 2),
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        'ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '(E 0.000138 ETH)',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  fontSize: 16),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(150);
}
