import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/ChangeName/ChangeName.dart';
import 'package:infinito_wallet/Screens/ChangePassword/ChangePassword.dart';

import '../../components/appbar.dart';

class SettingWalletPage extends StatelessWidget {
  bool _value = false;

  SettingWalletPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = "Infinito Wallet";
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: 44,
                    height: 44,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          onPressed: () {},
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.red,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50),
                          )),
                    ),
                  ),
                  Text(
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
  final String title;
  final void Function() tap;
  const LineBtn({
    Key? key,
    required this.title,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
        )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );
  }
}
