import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  final bool login;
  final void Function() press; 
  const AlreadyHaveAccount({
    Key? key,
    this.login = true,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          login ? 'Bạn không có tài khoản?' : 'Bạn đã có tài khoản?'
        ),
        TextButton(
          child: Text(
            login ? 'Đăng ký' : 'Đăng nhập',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: press,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}