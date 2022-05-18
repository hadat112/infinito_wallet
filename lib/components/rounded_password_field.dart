import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/text_field_container.dart';

mixin PasswordFieldValidator {
  static String? validate(String? value) {
    // final RegExp regex = RegExp(r'^.{6,}$');

    final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (value!.isEmpty) {
      return 'Yêu cầu nhập mật khẩu';
    }
    if (!regex.hasMatch(value)) {
      return 'Nhập đúng định dạng mật khẩu (Tối thiểu 8 kí tự)';
    }
    return null;
  }
}

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField(
      {Key? key,
      required this.onChanged,
      required this.inputTitle,
      required this.aToZ,
      required this.passwordController})
      : super(key: key);

  final ValueChanged<String> onChanged;
  final String inputTitle;
  final bool aToZ;
  final TextEditingController passwordController;

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hide = true;

  void _toggle() {
    setState(() {
      hide = !hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
        child: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.inputTitle,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600))),
        SizedBox(height: size.height * 0.005),
        TextFormField(
            key: widget.key,
            scrollPadding: const EdgeInsets.only(bottom: 80),
            controller: widget.passwordController,
            obscureText: hide,
            validator: PasswordFieldValidator.validate,
            onSaved: (value) {
              widget.passwordController.text = value!;
            },
            textInputAction: TextInputAction.done,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: _toggle,
                icon: const Icon(Icons.visibility,
                    color: Color.fromRGBO(90, 195, 240, 1)),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            )),
        if (widget.aToZ == true)
          const Align(
              alignment: Alignment.centerRight,
              child: Text('A-Z, a-z, 0-9, !@#%',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)))
      ],
    ));
  }
}
