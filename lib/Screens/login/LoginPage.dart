import 'package:flutter/material.dart';

import '../../components/already_have_account.dart';
import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../Signup/SignUpPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _title = "Đăng nhập";
    return Scaffold(
      appBar: const Appbar(title: _title),
      body: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                inputTitle: "Email",
                onChanged: (value) {}
              ),
              RoundedPasswordField(onChanged:(value) {}, inputTitle: 'Mật khẩu', aToZ: false,),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Quên mật khẩu',
                ),
              ),
              RoundedButton(text: "Đăng nhập", press: () {}),
              AlreadyHaveAccount(press:() {
                Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                  return SignUpPage();
                }
              )
            );
              },),
            ],
          ));
  }
}