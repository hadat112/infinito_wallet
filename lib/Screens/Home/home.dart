import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Home/walletInfo.dart';
import 'package:infinito_wallet/Screens/SendCrypto/SendCrypto.dart';
import 'package:infinito_wallet/models/wallet.dart';
import 'package:infinito_wallet/services/database.dart';
import 'package:provider/provider.dart';

import '../../components/bottom_navigation.dart';
import '../../components/circle_button.dart';
import '../../components/small_button.dart';
import '../../services/auth.dart';
import '../BuyCrypto/BuyCrypto.dart';
import '../TradeCoin/TradeCoin.dart';
import 'package:infinito_wallet/services/database.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
    final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamProvider<Wallet?>.value(
      value: DatabaseService(uid: _auth.getCurrentUser()!.uid).wallets,
      initialData: null,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: walletInfo()
        ),
        body: Table(children: [
          TableRow(children: [
            CircleBtn(
              path: 'assets/send.png',
              text: 'Nạp-Gửi',
              tap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SendCryptoPage();
                }));
              },
            ),
            CircleBtn(
              path: 'assets/buy.png',
              text: 'Mua Crypto',
              tap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const BuyCryptoPage();
                }));
              },
            ),
            CircleBtn(
              path: 'assets/trade.png',
              text: 'Trade Crypto',
              tap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TradeCoinPage();
                }));
              },
            ),
          ]),
          TableRow(children: [
            CircleBtn(
              path: 'assets/tygia.png',
              text: 'Tỷ giá',
              tap: () {},
            ),
            CircleBtn(
              path: 'assets/thitruong.png',
              text: 'Tín hiệu thị trường',
              tap: () {},
            ),
            CircleBtn(
              path: 'assets/gift.png',
              text: 'Tặng thưởng',
              tap: () {},
            ),
          ])
        ]),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
