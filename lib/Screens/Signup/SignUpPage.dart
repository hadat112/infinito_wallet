import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _title = "Thiết lập";
    return Scaffold(
      appBar: const Appbar(title: _title),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          RoundedInputField(
            inputTitle: "Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
            inputTitle: 'Mật khẩu đăng nhập tài khoản',
            aToZ: true,
          ),
          RoundedInputField(
            inputTitle: "Quốc gia",
            onChanged: (value) {},
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Color.fromRGBO(215, 241, 240, 1),
            margin: EdgeInsets.symmetric(vertical: 25),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.add_task_outlined),
                Text("  Đặt mật khẩu giao dịch"),
                Text("(nên dùng)",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5)
                  )
                )
              ],),
              RoundedPasswordField(onChanged: (value) {}, inputTitle: 'Mật khẩu giao dịch', aToZ: true,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Lưu ý:",),
                Text("Mật khẩu giao dịch dùng để gửi tiền",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.5)
                  )
                )
              ],),
            ]),),
            Text("Bạn đồng ý với Chính sách bảo mật của chúng tôi"),
            RoundedButton(
              text: "Đăng ký",
              press: (() {
              
            }))
        ]
      )
    );
  }
}