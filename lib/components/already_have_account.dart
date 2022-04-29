import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    Key? key,
    this.login = true,
    required this.press
  }) : super(key: key);

  final bool login;
  final void Function() press; 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? 'Bạn không có tài khoản?' : 'Bạn đã có tài khoản?'
        ),
        TextButton(
          onPressed: press,
          child: Text(
            login ? 'Đăng ký' : 'Đăng nhập',
            style: const TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }
}