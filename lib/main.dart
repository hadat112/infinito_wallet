import 'package:flutter/material.dart';

import 'Screens/Signup/SignUpPage.dart';
import 'Screens/login/LoginPage.dart';
import 'components/appbar.dart';
import 'components/rounded_button.dart';
import 'components/white_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const String _title = 'Bắt đầu';
    return MaterialApp(
      home: Scaffold(
        appBar: Appbar(title: _title),
        body: StartPage(),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column (
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
    );
  }
}
