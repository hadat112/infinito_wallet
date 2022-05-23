import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_password_field.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Thay đổi mật khẩu';
    return Scaffold(
      appBar: const Appbar(title: _title),
      body: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedPasswordField(
                passwordController: passwordController,
                inputTitle: 'Mật khẩu hiện tại',
                onChanged: (value) {},
                aToZ: false,
              ),
                            SizedBox(height: size.height * 0.04),

              RoundedPasswordField(
                passwordController: passwordController,
                onChanged:(value) {}, inputTitle: 'Mật khẩu mới',
              aToZ: true,),
              SizedBox(height: size.height * 0.05),
              RoundedButton(text: 'Cập nhật', press: () {}),
            ],
          ));
  }
}