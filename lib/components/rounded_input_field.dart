import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String inputTitle;
  final ValueChanged<String> onChanged;
  final String validateText;

  final TextEditingController inputEditingController;
  const RoundedInputField(
      {Key? key,
      this.hintText = '',
      required this.onChanged,
      required this.inputTitle,
      required this.inputEditingController,
      this.validateText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        child: Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(inputTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      SizedBox(height: size.height * 0.005),
      TextFormField(
        autofocus: false,
        controller: inputEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return validateText;
          }
          return null;
        },
        onSaved: (value) {
          inputEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
          ),
        ),
      )
    ]));
  }
}
