import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/wallet.dart';
import '../services/coin_data.dart';

class SendCoinAppBar extends StatefulWidget with PreferredSizeWidget {
  SendCoinAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<SendCoinAppBar> createState() => _SendCoinAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(170);
}

class _SendCoinAppBarState extends State<SendCoinAppBar> {
  String getInitials({String? string, int? limitTo}) {
    var buffer = StringBuffer();
    var split = string?.split(' ');
    for (var i = 0; i < (limitTo ?? split!.length); i++) {
      buffer.write(split?[i][0]);
    }
    return buffer.toString().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<Wallet?>(context);
    final double? amount = wallet?.amount;
    final String? walletName = wallet?.wallet_name;
    final String initialsName = getInitials(string: walletName, limitTo: 2);
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: Container(
        margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(colors: <Color>[
            Color.fromRGBO(7, 15, 87, 1),
            Color.fromRGBO(80, 178, 200, 1)
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white),
                ),
              ),
              child: Row(children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                  ),
                  child: Center(
                      child: Text(
                    initialsName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${wallet?.wallet_name}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ),
            Card(
              color: const Color.fromRGBO(71, 145, 176, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29),
              ),
              child: Container(
                height: 37,
                width: widget.size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(90, 195, 240, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40)),
                      ),
                      child: Center(
                          child: Text(
                        initialsName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${amount}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: const Text(
                        'ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '(E 0.000138 ETH)',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  fontSize: 16),
            ),
          ]),
        ),
      ),
    );
  }
}
