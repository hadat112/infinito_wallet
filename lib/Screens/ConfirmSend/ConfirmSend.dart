import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_password_field.dart';
import '../../components/sendcoin_appbar.dart';
import '../../components/white_button.dart';

class ConfirmSendCryptoPage extends StatelessWidget {
  ConfirmSendCryptoPage({Key? key}) : super(key: key);
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: SendCoinAppBar(size: size, selectedCurrency: '', coinValue: ,),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sending',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 16),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '0.1 ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 26),
                      ),
                      SizedBox(
                        width: 5,
                      ),
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
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Gửi tới địa chỉ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(150, 227, 244, 1),
                      border:
                          Border.all(color: const Color.fromRGBO(150, 227, 244, 1)),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
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
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Fee',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(150, 227, 244, 1),
                      border:
                          Border.all(color: const Color.fromRGBO(150, 227, 244, 1)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '0.1 ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 5,
                      ),
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
            const SizedBox(
              height: 20,
            ),
            RoundedPasswordField(
                passwordController: passwordController,
                inputTitle: 'Mật khẩu giao dịch',
                onChanged: (value) {},
                aToZ: false),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WhiteButton(
                  text: 'Huỷ bỏ',
                  press: () {
                    Navigator.pop(context);
                  },
                  textColor: Colors.black,
                  btnWidth: 180,
                ),
                RoundedButton(
                  text: 'Gửi',
                  press: () {},
                  btnWidth: 180,
                ),
              ],
            ),
          ],
        ));
  }
}
