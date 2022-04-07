import 'dart:collection';

import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../../components/sendcoin_appbar.dart';
import '../../components/white_button.dart';

class ConfirmSendCryptoPage extends StatelessWidget {
  const ConfirmSendCryptoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: SendCoinAppBar(size: size),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sending',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 16),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '0.1 ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 26),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        '0.0043 USD',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Gửi tới địa chỉ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(150, 227, 244, 1),
                      border:
                          Border.all(color: Color.fromRGBO(150, 227, 244, 1)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'fadsfahfkư12en2jkn2k',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Fee',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(150, 227, 244, 1),
                      border:
                          Border.all(color: Color.fromRGBO(150, 227, 244, 1)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '0.1 ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        '0.0043 USD',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            RoundedPasswordField(
                inputTitle: "Mật khẩu giao dịch", onChanged: (value) {}, aToZ: false ),
            SizedBox(
              height: size.height*0.24,
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
