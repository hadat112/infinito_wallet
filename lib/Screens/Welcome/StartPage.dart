import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/white_button.dart';
import '../Signup/SignUpPage.dart';
import '../login/LoginPage.dart';

class StartPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = 'Bắt đầu';

    return Scaffold(
      appBar:  const Appbar(title: _title),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
              width: size.width,
              child: Image.asset('assets/start.jpg')
            ),
          ),
          Align(alignment: Alignment.center,
          child: RoundedButton(
            text: "Đăng nhập",
            press: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  }
                )
              );
              }
          ),
          ),
          Align(alignment: Alignment.center,
          child: WhiteButton(
            text: "Đăng Ký",
            textColor: Color.fromRGBO(90, 195, 240, 1),
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
