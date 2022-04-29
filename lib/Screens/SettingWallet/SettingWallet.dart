import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/ChangeName/ChangeName.dart';
import 'package:infinito_wallet/Screens/ChangePassword/ChangePassword.dart';

import '../../components/appbar.dart';

class SettingWalletPage extends StatelessWidget {
  const SettingWalletPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const String _title = 'Infinito Wallet';
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                LineBtn(
                  title: 'Đặt lại tên ví',
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChangeName();
                    }));
                  },
                ),
                LineBtn(
                  title: 'Thay đổi mật khẩu giao dịch',
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChangePassword();
                    }));
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: 44,
                    height: 44,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                    ),
                  ),
                  const Text(
                    'Xoá ví',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LineBtn extends StatelessWidget {
  const LineBtn({
    Key? key,
    required this.title,
    required this.tap,
  }) : super(key: key);

  final String title;
  final void Function() tap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4)),
        )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );
  }
}
