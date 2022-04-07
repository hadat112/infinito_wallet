import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_password_field.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = "Thay đổi mật khẩu";
    return Scaffold(
      appBar: const Appbar(title: _title),
      body: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedPasswordField(
                inputTitle: "Mật khẩu hiện tại",
                onChanged: (value) {},
                aToZ: false,
              ),
              RoundedPasswordField(onChanged:(value) {}, inputTitle: 'Mật khẩu mới',
              aToZ: true,),
              SizedBox(height: size.height * 0.05),
              RoundedButton(text: "Cập nhật", press: () {}),
            ],
          ));
  }
}