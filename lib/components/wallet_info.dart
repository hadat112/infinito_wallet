import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinito_wallet/models/wallet.dart';
import 'package:infinito_wallet/services/database.dart';

import '../services/auth.dart';
import 'circle_icon.dart';

class WalletInfo extends StatefulWidget {
  WalletInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  final AuthService _auth = AuthService();
  Wallet? wallet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double? amount = wallet?.amount;
    final String? walletName = wallet?.wallet_name;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Ví',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
        ),
        Card(
          color: const Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29),
          ),
          child: Container(
            height: 60,
            width: size.width * 0.9,
            // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const IconCircle(
                  textInside: 'IW',
                  circleSize: 60,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.getCurrentUser()?.uid)
                    .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                    return const Center();
                  }
                        return Text(
                          snapshot.data!.get('wallet_name'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }
                    ),
                     Text(
                        _auth.getCurrentUser()!.uid,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(7, 15, 87, 1)),
                      )     
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
