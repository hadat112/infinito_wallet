import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

mixin EmailFieldValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
            return 'Hãy nhập Email của bạn';
          }
          // reg expression for email validation
          if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
              .hasMatch(value)) {
            return 'Email không hợp lệ';
          }
          return null;
  }
}

class RoundedEmailField extends StatelessWidget {
  const RoundedEmailField({
    Key? key,
    this.hintText = '',
    required this.onChanged, required this.inputTitle, this.validateText = '', required this.emailController
  }) : super(key: key);
  
  final String hintText;
  final String inputTitle;
  final String validateText;
  final TextEditingController emailController;

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      child: Column(children: [
      Align(
            alignment: Alignment.centerLeft,
            child: Text(inputTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      SizedBox(height: size.height*0.005),
       TextFormField(
         key: key,
         scrollPadding: const EdgeInsets.only(
            bottom: 80),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: EmailFieldValidator.validate,
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        decoration:  InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      )
    ])
    );
  }
}
