import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/ChangePassword/change_password.dart';

import '../../components/appbar.dart';
import '../../components/line_btn.dart';
import '../ChangeWalletName/change_wallet_name.dart';

class DifferentSettingPage extends StatelessWidget {
  const DifferentSettingPage({Key? key}) : super(key: key);
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
                  title: 'Các điều khoản',
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute<dynamic>(builder: (context) {
                      return ChangeWalletName();
                    }));
                  },
                ),
                LineBtn(
                  title: 'Chính sách riêng tư',
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
