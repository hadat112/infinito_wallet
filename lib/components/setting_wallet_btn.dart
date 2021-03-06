import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Screens/SettingWallet/setting_wallet.dart';
import 'circle_icon.dart';

class SettingWalletButton extends StatefulWidget {
  const SettingWalletButton({
    Key? key,
    this.walletName = '',
  }) : super(key: key);

  final String walletName;

  @override
  State<SettingWalletButton> createState() => _SettingWalletButtonState();
}

class _SettingWalletButtonState extends State<SettingWalletButton> {
  double _opacity = 1;
  String getInitials({String? string, int? limitTo}) {
    final buffer = StringBuffer();
    final split = string?.split(' ');
    if ((split?.length ?? 1) >= 2) {
      for (var i = 0; i < (limitTo ?? split!.length); i++) {
        buffer.write(split![i][0]);
      }
      return buffer.toString().toUpperCase();
    }
    return string ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: _opacity,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute<dynamic>(builder: (context) {
            return const SettingWalletPage();
          }));
        },onTapDown: (TapDownDetails details) {
            setState(() {
              _opacity = 0.3;
            });
          },
          onTapUp: (TapUpDetails details) {
            setState(() {
              _opacity = 1;
            });
          },
          onTapCancel: (){
            setState(() {
              _opacity = 1;
            });
          },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 15.h, horizontal: 20.w),
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4)),
          )),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconCircle(
                      circleSize: 30.h,
                      textInside:
                          getInitials(string: widget.walletName, limitTo: 2),
                      textSize: 12.sp,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.walletName,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                 Icon(Icons.arrow_forward_ios,
                size: 20.sp,)
              ]),
        ),
      ),
    );
  }
}