import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Home/home.dart';
import 'package:infinito_wallet/Screens/Setting/setting_page.dart';

import 'icon_text.dart';


bool onHome = true;
bool onSetting = false;

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);


  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconText(
                  text: 'Home',
                  icon: Icons.home,
                  color: onHome ? Colors.blueAccent : const Color.fromRGBO(0, 0, 0, 0.6),
                  tap: () {
                    if(!onHome) {
                      setState(() {
                      onHome = true;
                      onSetting = false;
                      });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => const Home(
                                )),
                        (route) => false);
                    }
                  }),
              // IconText(
              //     text: 'Wallet',
              //     icon: Icons.wallet_membership_outlined,
              //     tap: () {
              //       // Navigator.push(context,
              //       //     MaterialPageRoute<dynamic>(builder: (context) {
              //       //   return SettingPage(
              //       //     onSignedOut: onSignedOut,
              //       //   );
              //       // }));
              //     }),
              IconText(
                  text: 'Account',
                  icon: Icons.account_circle_outlined,
                  color: onSetting ? Colors.blueAccent : const Color.fromRGBO(0, 0, 0, 0.6),
                  tap: () {
                    if(!onSetting) {
                      setState(() {                       
                    onSetting = true; 
                    onHome = false; 
                      });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (context) => SettingPage(
                                )),
                        (route) => false);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}