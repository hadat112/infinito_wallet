import 'package:flutter/material.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/white_button.dart';
import '../Signup/sign_up_page.dart';
import '../login/login_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {


  

  @override
  void initState() {
    super.initState();
    final AuthService auth = AuthService();
    auth.currentUser().then((userId) {});
  }

  @override
  Widget build(BuildContext context) {
    didChangeDependencies();
    // if (MediaQuery.of(context).size.width < 300){
  //height = 25% of the screen 
// }
// else if(MediaQuery.of(context).size.width > 700){
//   btnWidth = MediaQuery.of(context).size.width * 0.10; // width = 10% of the screen
//   btnHeight = MediaQuery.of(context).size.height * 0.10; //height = 10% of the screen 
// }
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Bắt đầu';

    return SafeArea(
      child: Scaffold(
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
                    Navigator.push(context,
                        MaterialPageRoute<dynamic>(builder: (context) => const LoginPage()
                    ));
                  }),
              WhiteButton(
                  text: 'Đăng Ký',
                  textColor: const Color.fromRGBO(90, 195, 240, 1),
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute<dynamic>(builder: (context) {
                      return const SignUpPage();
                    }));
                  }),
            ]),
      ),
    );
  }
}
