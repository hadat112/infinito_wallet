import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Loading/loading.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/already_have_account.dart';
import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_email_field.dart';
import '../../components/rounded_password_field.dart';
import '../Signup/SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final AuthService _auth = AuthService();

  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    const String _title = 'Đăng nhập';
    return loading ? Loading() : GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: const Appbar(title: _title),
          body: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RoundedEmailField(
                        emailController: emailController,
                        validateText: 'Bạn chưa nhập Email',
                        inputTitle: 'Email',
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 30,
                    ),
                    RoundedPasswordField(
                      passwordController: passwordController,
                      onChanged: (value) {},
                      inputTitle: 'Mật khẩu',
                      aToZ: false,
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      child: const Text(
                        'Quên mật khẩu',
                      ),
                    ),
                    RoundedButton(
                        text: 'Đăng nhập',
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text,
                                    context);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        }),
                    AlreadyHaveAccount(
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUpPage();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
