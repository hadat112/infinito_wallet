import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Home/home.dart';
import 'package:infinito_wallet/Screens/Setting/setting.dart';

import 'icon_text.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    required this.onSignedOut,
  }) : super(key: key);

  final VoidCallback onSignedOut;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool onHome = true;

  bool onSetting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      // color: Colors.white,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffE0E0E0))),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 51, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(
                  text: 'Home',
                  icon: Icons.home,
                  tap: () {
                    print(onHome);
                      print(onSetting);
                    if(!onHome) {
                      setState(() {
                      onHome = true;
                      onSetting = false;
                      });
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => Home(
                                  onSignedOut: () {},
                                )),
                        (route) => false);
                  }),
              IconText(
                  text: 'Wallet',
                  icon: Icons.wallet_membership_outlined,
                  tap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute<dynamic>(builder: (context) {
                    //   return SettingPage(
                    //     onSignedOut: onSignedOut,
                    //   );
                    // }));
                  }),
              IconText(
                  text: 'Account',
                  icon: Icons.account_circle_outlined,
                  tap: () {
                    if(!onSetting) {
                      setState(() {
                        
                    onSetting = true; 
                    onHome = false; 
                      });
                      print(onHome);
                      print(onSetting);
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => SettingPage(
                                  onSignedOut: widget.onSignedOut,
                                )),
                        (route) => false);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}