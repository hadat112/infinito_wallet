import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/already_have_account.dart';
import '../../components/appbar.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_email_field.dart';
import '../../components/rounded_password_field.dart';
import '../Home/home.dart';
import '../Signup/SignUpPage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    const String _title = "Đăng nhập";
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedEmailField(
                  emailController: emailController,
                  validateText: "Bạn chưa nhập Email",
                  inputTitle: "Email",
                  onChanged: (value) {}),
              SizedBox(
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
                  text: "Đăng nhập",
                  press: () {
                    signIn(emailController.text, passwordController.text, context);
                  }),
              AlreadyHaveAccount(
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpPage();
                  }));
                },
              ),
            ],
          ),
        ));
  }

  void signIn(String email, String password, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
