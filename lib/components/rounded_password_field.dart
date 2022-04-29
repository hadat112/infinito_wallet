import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField(
      {Key? key,
      required this.onChanged,
      required this.inputTitle,
      required this.aToZ, required this.passwordController})
      : super(key: key);

  final ValueChanged<String> onChanged;
  final String inputTitle;
  final bool aToZ;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
        child: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(inputTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
        SizedBox(height: size.height * 0.005),
        TextFormField(
          scrollPadding: EdgeInsets.only(
            bottom: 80),
            controller: passwordController,
        obscureText: true,
        validator: (value) {
          final RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return 'Yêu cầu nhập mật khẩu';
          }
          if (!regex.hasMatch(value)) {
            return 'Enter Valid Password(Min. 6 Character)';
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
            onChanged: onChanged,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.visibility,
                  color: Color.fromRGBO(90, 195, 240, 1)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            )),
        if (aToZ == true)
          const Align(
              alignment: Alignment.centerRight,
              child: Text('A-Z, a-z, 0-9, !@#%',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)))
      ],
    ));
  }
}
