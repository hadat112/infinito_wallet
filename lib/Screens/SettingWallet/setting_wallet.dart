import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/ChangePassword/change_password.dart';

import '../../components/appbar.dart';
import '../ChangeWalletName/change_wallet_name.dart';

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
                        MaterialPageRoute<dynamic>(builder: (context) {
                      return ChangeWalletName();
                    }));
                  },
                ),
                LineBtn(
                  title: 'Thay đổi mật khẩu giao dịch',
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute<dynamic>(builder: (context) {
                      return ChangePassword();
                    }));
                  },
                ),
              ],
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
