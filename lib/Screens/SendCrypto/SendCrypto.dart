import 'dart:collection';

import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/sendcoin_appbar.dart';
import '../../components/white_button.dart';

class SendCryptoPage extends StatelessWidget {
  const SendCryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: SendCoinAppBar(size: size),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            RoundedInputField(
                inputTitle: "Gửi tới địa chỉ", onChanged: (value) {}),
            SizedBox(
              height: 25,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Số lượng",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                ),
                SizedBox(height: size.height * 0.005),
                Container(
                  height: 60,
                  width: size.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.4)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(28, 149, 214, 1),
                            fontSize: 18),
                      ),
                      VerticalDivider(
                        thickness: 2,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                          child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                      Text(
                        '0 USD',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 45,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(150, 227, 244, 1),
                    border: Border.all(color: Color.fromRGBO(150, 227, 244, 1)),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Giao dịch',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 45,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(150, 227, 244, 1)),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Tổng',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: size.width * 0.28),
                      Text(
                        '0.170103 ADA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '0.0073 USD',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height*0.29,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WhiteButton(
                  text: "Huỷ bỏ",
                  press: () {},
                  textColor: Colors.black,
                  btnSize: "S",
                ),
                RoundedButton(text: "Gửi", press: () {}, btnSize: "S",),
              ],
            ),
          ],
        ));
  }
}

