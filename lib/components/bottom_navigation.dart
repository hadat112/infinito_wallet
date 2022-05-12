import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Home/home.dart';
import 'package:infinito_wallet/Screens/Setting/Setting.dart';

import 'icon_text.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key, required this.onSignedOut,
  }) : super(key: key);
  final VoidCallback onSignedOut;


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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home(onSignedOut: () {  },);
                    }));
                  }),
              IconText(
                  text: 'Wallet',
                  icon: Icons.wallet_membership_outlined,
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingPage(onSignedOut: onSignedOut,);
                    }));
                  }),
              IconText(
                  text: 'Account',
                  icon: Icons.account_circle_outlined,
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingPage(onSignedOut: onSignedOut,);
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}