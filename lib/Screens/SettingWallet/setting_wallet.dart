import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/ChangePassword/change_password.dart';

import '../../components/appbar.dart';
import '../../components/line_btn.dart';
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
