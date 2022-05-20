import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Loading/loading.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/already_have_account.dart';
import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_email_field.dart';
import '../../components/rounded_password_field.dart';
import '../Signup/sign_up_page.dart';

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
    return loading ? const Loading() : GestureDetector(
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
                      key: const Key('email'),
                        emailController: emailController,
                        validateText: 'Bạn chưa nhập Email',
                        inputTitle: 'Email',
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 30,
                    ),
                    RoundedPasswordField(
                      key: const Key('password'),
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
                      key: const Key('signIn'),
                        text: 'Đăng nhập',
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            final dynamic result =
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
                            MaterialPageRoute<dynamic>(builder: (context) {
                          return const SignUpPage();
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
