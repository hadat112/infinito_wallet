import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin PasswordFieldValidator {
  static String? validate(String? value) {
    // final RegExp regex = RegExp(r'^.{6,}$');

    final RegExp regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
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

    return Container(
        width: size.width * 0.9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.inputTitle,
                      style: TextStyle(
                          fontSize: 16.h, fontWeight: FontWeight.w600))),
            ),
            SizedBox(height: 4.h),
            Container(
              height: size.height * 0.075,
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                  style: TextStyle(fontSize: 14.sp),
                  key: widget.key,
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
                      iconSize: 14.sp,
                      icon: const Icon(Icons.visibility,
                          color: Color.fromRGBO(90, 195, 240, 1)),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                    ),
                  )),
            ),
            if (widget.aToZ == true)
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('A-Z, a-z, 0-9, !@#%',
                      style: TextStyle(
                          fontSize: 12.h, fontWeight: FontWeight.w300)))
          ],
        ));
  }
}
