import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/rounded_button.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/appbar.dart';
import '../../components/rounded_email_field.dart';
import '../../components/rounded_password_field.dart';
import '../Loading/loading.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();

  // our form key
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

  // editing Controller
  final countryEditingController = TextEditingController();

  final emailEditingController = TextEditingController();

  final passwordEditingController = TextEditingController();

  final transactionPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    const String _title = 'Thiết lập';
    return loading ? Loading() : Scaffold(
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
                      emailController: emailEditingController,
                      inputTitle: 'Email',
                      onChanged: (value) {},
                    ),
                    RoundedPasswordField(
                      passwordController: passwordEditingController,
                      onChanged: (value) {},
                      inputTitle: 'Mật khẩu đăng nhập tài khoản',
                      aToZ: true,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Column(children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Quốc Gia',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600))),
                          SizedBox(height: size.height * 0.005),
                          Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromRGBO(0, 0, 0, 0.4)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CountryCodePicker(
                              onInit: (countryCode) {
                                countryEditingController.text =
                                    countryCode?.name! as String;
                              },
                              onChanged: (CountryCode countryCode) {
                                countryEditingController.text =
                                    countryCode.name!;
                              },
                              initialSelection: 'VN',
                              showOnlyCountryWhenClosed: true,
                              showCountryOnly: true,
                              alignLeft: true,
                              flagDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ])),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: const Color.fromRGBO(215, 241, 240, 1),
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_task_outlined),
                            Text('  Đặt mật khẩu giao dịch'),
                            Text('(nên dùng)',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5)))
                          ],
                        ),
                        RoundedPasswordField(
                          passwordController:
                              transactionPasswordEditingController,
                          onChanged: (value) {},
                          inputTitle: 'Mật khẩu giao dịch',
                          aToZ: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Lưu ý:',
                            ),
                            Text('Mật khẩu giao dịch dùng để gửi tiền',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5)))
                          ],
                        ),
                      ]),
                    ),
                    const Text(
                        'Bạn đồng ý với Chính sách bảo mật của chúng tôi'),
                    RoundedButton(
                        text: 'Đăng ký',
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.signUp(
                                emailEditingController.text,
                                passwordEditingController.text,
                                countryEditingController.text,
                                transactionPasswordEditingController.text,
                                context);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        })
                  ]),
            ),
          ),
        ));
  }
}
