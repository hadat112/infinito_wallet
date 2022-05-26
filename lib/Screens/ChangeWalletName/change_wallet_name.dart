import 'package:flutter/material.dart';
import 'package:infinito_wallet/services/auth.dart';
import 'package:infinito_wallet/services/database.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';

class ChangeWalletName extends StatelessWidget {
  ChangeWalletName({Key? key}) : super(key: key);
  final inputEditingController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Đặt lại tên';
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(inputEditingController: inputEditingController, onChanged: (value) {
              }, inputTitle: 'Tên ví'),
              SizedBox(height: size.height * 0.05),
              RoundedButton(text: 'Cập nhật', press: () {
                DatabaseService(uid: _auth.getCurrentUser()!.uid).changeName(inputEditingController.text, 'wallet_name');
                Navigator.pop(context);
              }),
            ],
          ),
        ));
  }
}