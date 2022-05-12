import 'package:flutter/material.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/white_button.dart';
import '../Home/home.dart';
import '../Signup/SignUpPage.dart';
import '../login/LoginPage.dart';

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void initState() {
    super.initState();
    final AuthService auth = AuthService();
    auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    didChangeDependencies();
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Bắt đầu';

    return Scaffold(
      appBar: const Appbar(title: _title),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  width: size.width,
                  child: Image.asset('assets/start.jpg')),
            ),
            RoundedButton(
                text: 'Đăng nhập',
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    switch (authStatus) {
                      case AuthStatus.notSignedIn:
                        return LoginPage(
                          onSignedIn: _signedIn,
                        );
                      case AuthStatus.signedIn:
                        return Home(
                          onSignedOut: _signedOut,
                        );
                    }
                    return StartPage();
                  }));
                }),
            Align(
              child: WhiteButton(
                  text: 'Đăng Ký',
                  textColor: const Color.fromRGBO(90, 195, 240, 1),
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUpPage();
                    }));
                  }),
            ),
          ]),
    );
  }
}
