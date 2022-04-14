import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

class RoundedEmailField extends StatelessWidget {
  final String hintText;
  final String inputTitle;
  final String validateText;
  final TextEditingController emailController;

  final ValueChanged<String> onChanged;
  const RoundedEmailField({
    Key? key,
    this.hintText = '',
    required this.onChanged, required this.inputTitle, this.validateText = "", required this.emailController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      child: Column(children: [
      Align(
            alignment: Alignment.centerLeft,
            child: Text(inputTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      SizedBox(height: size.height*0.005),
       TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Hãy nhập Email của bạn");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Email không hợp lệ");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        decoration:  InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
          ),
        ),
      )
    ])
    );
  }
}
