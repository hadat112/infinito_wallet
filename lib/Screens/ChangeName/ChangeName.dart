import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = "Đặt lại tên";
    return Scaffold(
      appBar: const Appbar(title: _title),
      body: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(onChanged:(value) {}, inputTitle: 'Tên ví'),
              SizedBox(height: size.height * 0.05),
              RoundedButton(text: "Cập nhật", press: () {}),
            ],
          ));
  }
}