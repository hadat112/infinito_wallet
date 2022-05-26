import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      width: size.width*0.9,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
          alignment: Alignment.centerLeft,
          child: Text(inputTitle,
              style:  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600))),
        ),
        SizedBox(height: 4.h),
        Container(
          height: size.height*0.06,
          child: TextFormField(
            style: TextStyle(fontSize: 14.sp),
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
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
      ),
          ),
        )
      ]),
    );
  }
}
