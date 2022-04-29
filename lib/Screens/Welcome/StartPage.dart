import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/white_button.dart';
import '../Signup/SignUpPage.dart';
import '../login/LoginPage.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Bắt đầu';

    return Scaffold(
      appBar:  const Appbar(title: _title),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              width: size.width,
              child: Image.asset('assets/start.jpg')
            ),
          ),
          RoundedButton(
            text: 'Đăng nhập',
            press: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  }
                )
              );
              }
          ),
          Align(child: WhiteButton(
            text: 'Đăng Ký',
            textColor: const Color.fromRGBO(90, 195, 240, 1),
            press: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpPage();
                  }
                )
              );
              }
          ),
          ),
        ]
      ),
    );
  }
}
