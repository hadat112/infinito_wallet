import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField(
      {Key? key,
      this.hintText = '',
      required this.onChanged,
      required this.inputTitle,
      required this.inputEditingController,
      this.validateText = ''})
      : super(key: key);

  final String hintText;
  final String inputTitle;
  final ValueChanged<String> onChanged;
  final String validateText;

  final TextEditingController inputEditingController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        child: Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(inputTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      SizedBox(height: size.height * 0.005),
      TextFormField(
        scrollPadding: const EdgeInsets.only(
            bottom: 80),
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
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
        ),
      )
    ]));
  }
}
