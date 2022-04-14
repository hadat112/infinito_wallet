import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinito_wallet/components/rounded_button.dart';
import 'package:infinito_wallet/model/user_model.dart';

import '../../components/appbar.dart';
import '../../components/rounded_email_field.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../Home/home.dart';

class SignUpPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  
  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final countryEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final transactionPasswordEditingController = new TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String _title = "Thiết lập";
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedEmailField(
                  emailController: emailEditingController,
                  inputTitle: "Email",
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  passwordController: passwordEditingController,
                  onChanged: (value) {},
                  inputTitle: 'Mật khẩu đăng nhập tài khoản',
                  aToZ: true,
                ),
                RoundedInputField(
                  inputEditingController: countryEditingController,
                  inputTitle: "Quốc gia",
                  onChanged: (value) {},
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Color.fromRGBO(215, 241, 240, 1),
                  margin: EdgeInsets.symmetric(vertical: 25),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_task_outlined),
                        Text("  Đặt mật khẩu giao dịch"),
                        Text("(nên dùng)",
                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)))
                      ],
                    ),
                    RoundedPasswordField(
                      passwordController: transactionPasswordEditingController,
                      onChanged: (value) {},
                      inputTitle: 'Mật khẩu giao dịch',
                      aToZ: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lưu ý:",
                        ),
                        Text("Mật khẩu giao dịch dùng để gửi tiền",
                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)))
                      ],
                    ),
                  ]),
                ),
                Text("Bạn đồng ý với Chính sách bảo mật của chúng tôi"),
                RoundedButton(text: "Đăng ký", press: (() {
                  signUp(emailEditingController.text, passwordEditingController.text, context);
                }))
              ]),
        ));
  }
  
  void signUp(String email, String password, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore(context)})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
  postDetailsToFirestore(BuildContext context) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.country = countryEditingController.text;
    userModel.transactionPassword = transactionPasswordEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false);
  }
}
