import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String inputTitle;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    this.hintText = '',
    required this.onChanged, required this.inputTitle
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
       TextField(
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
