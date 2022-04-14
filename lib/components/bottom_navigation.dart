import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Setting/Setting.dart';

import 'icon_text.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

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
          padding: EdgeInsets.only(left: 40, right: 51, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconText(
                  text: "Home",
                  icon: Icons.home,
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingPage();
                    }));
                  }),
              IconText(
                  text: "Wallet",
                  icon: Icons.wallet_membership_outlined,
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingPage();
                    }));
                  }),
              IconText(
                  text: "Account",
                  icon: Icons.account_circle_outlined,
                  tap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingPage();
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
