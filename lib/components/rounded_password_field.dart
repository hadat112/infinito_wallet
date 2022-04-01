import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String inputTitle;

  const RoundedPasswordField({Key? key, required this.onChanged, required this.inputTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        child: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(inputTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
        SizedBox(height: size.height*0.005),
        TextField(
            obscureText: true,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.visibility,
                  color: Color.fromRGBO(90, 195, 240, 1)),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(const Radius.circular(8)),
              ),
            )),
        Align(
            alignment: Alignment.centerRight,
            child: Text('A-Z, a-z, 0-9, !@#%',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)))
      ],
    ));
  }
}
