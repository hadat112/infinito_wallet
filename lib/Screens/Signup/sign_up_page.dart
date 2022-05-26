import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinito_wallet/components/already_have_account.dart';
import 'package:infinito_wallet/components/rounded_button.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/appbar.dart';
import '../../components/rounded_email_field.dart';
import '../../components/rounded_password_field.dart';
import '../Loading/loading.dart';
import '../login/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
    return loading
        ? const Loading()
        : GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
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
                              emailController: emailEditingController,
                              inputTitle: 'Email',
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 20.h,),
                            RoundedPasswordField(
                              passwordController: passwordEditingController,
                              onChanged: (value) {},
                              inputTitle: 'Mật khẩu đăng nhập tài khoản',
                              aToZ: true,
                            ),
                            Container(
                                width: size.width * 0.9,
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: Column(children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Quốc Gia',
                                          style: TextStyle(
                                              fontSize: 16.h,
                                              fontWeight: FontWeight.w600))),
                                  SizedBox(height: 4.h),
                                  Container(
                                    height: size.height*0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 0.4)),
                                      borderRadius: BorderRadius.circular(28),
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
                                      textStyle: TextStyle(
                                        fontSize: 14.h,
                                        color: Colors.black
                                      ),
                                      initialSelection: 'VN',
                                      showOnlyCountryWhenClosed: true,
                                      showCountryOnly: true,
                                      alignLeft: true,
                                      flagWidth: 32.sp,
                                      flagDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                  ),
                                ])),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              color: const Color.fromRGBO(215, 241, 240, 1),
                              margin: EdgeInsets.only(top: 25.h),
                              child: Column(children: [
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: const [
                                //     Icon(Icons.add_task_outlined),
                                //     Text('  Đặt mật khẩu giao dịch'),
                                //     Text('(nên dùng)',
                                //         style: TextStyle(
                                //             color: Color.fromRGBO(0, 0, 0, 0.5)))
                                //   ],
                                // ),
                                RoundedPasswordField(
                                  passwordController:
                                      transactionPasswordEditingController,
                                  onChanged: (value) {},
                                  inputTitle: 'Mật khẩu giao dịch',
                                  aToZ: true,
                                ),
                                SizedBox( height: 16.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      'Lưu ý:',
                                      style: TextStyle(
                                          fontSize: 16.h,
                                            color: const Color.fromRGBO(0, 0, 0, 0.5))
                                    ),
                                    Text('Mật khẩu giao dịch dùng để gửi tiền',
                                        style: TextStyle(
                                          fontSize: 16.h,
                                            color: const Color.fromRGBO(0, 0, 0, 0.5)))
                                  ],
                                ),
                              ]),
                            ),
                            AlreadyHaveAccount(
                              press: () {
                                Navigator.push(context,
                                    MaterialPageRoute<dynamic>(builder: (context) {
                                  return const LoginPage();
                                }));
                              },
                              login: false,
                            ),
                            SizedBox(height: 2.h,),
                            // const Text(
                            //     'Bạn đồng ý với Chính sách bảo mật của chúng tôi'),
                            RoundedButton(
                                text: 'Đăng ký',
                                press: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    final dynamic result = await _auth.signUp(
                                        emailEditingController.text,
                                        passwordEditingController.text,
                                        countryEditingController.text,
                                        transactionPasswordEditingController.text,
                                        context,
                                        loading);
                  
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
                )),
          ),
        );
  }
}
