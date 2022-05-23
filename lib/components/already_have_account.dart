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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            login ? 'Bạn không có tài khoản?' : 'Bạn đã có tài khoản?'
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: press,
            child: Text(
              login ? 'Đăng ký' : 'Đăng nhập',
              style: const TextStyle(fontSize: 20,
              color: Colors.blueAccent),
            ),
          )
        ],
      ),
    );
  }
}