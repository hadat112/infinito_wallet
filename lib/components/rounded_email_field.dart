import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin EmailFieldValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Hãy nhập Email của bạn';
    }
    // reg expression for email validation
    if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }
}

class RoundedEmailField extends StatelessWidget {
  const RoundedEmailField(
      {Key? key,
      this.hintText = '',
      required this.onChanged,
      required this.inputTitle,
      this.validateText = '',
      required this.emailController})
      : super(key: key);

  final String hintText;
  final String inputTitle;
  final String validateText;
  final TextEditingController emailController;

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.9,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(inputTitle,
                    style: TextStyle(
                        fontSize: 16.h, fontWeight: FontWeight.w600))),
          ),
          SizedBox(height: size.height * 0.005),
          Container(
            height: size.height * 0.075,
            child: TextFormField(
              style: TextStyle(fontSize: 14.sp),
              key: key,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: EmailFieldValidator.validate,
              onSaved: (value) {
                emailController.text = value!;
              },
              textInputAction: TextInputAction.next,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
              ),
            ),
          )
        ]));
  }
}
