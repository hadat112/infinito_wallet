import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding:  EdgeInsets.all(8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FittedBox(
            child: Text(
              login ? 'Bạn không có tài khoản?' : 'Bạn đã có tài khoản?',
                              style: TextStyle(fontSize: 14.h,)

            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: press,
            child: FittedBox(
              child: Text(
                login ? 'Đăng ký' : 'Đăng nhập',
                style: TextStyle(fontSize: 16.h,
                color: Colors.blueAccent),
              ),
            ),
          )
        ],
      ),
    );
  }
}