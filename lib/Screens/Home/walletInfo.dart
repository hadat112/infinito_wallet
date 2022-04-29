import 'package:flutter/material.dart';
import 'package:infinito_wallet/models/wallet.dart';
import 'package:provider/provider.dart';

import '../../components/small_button.dart';

class walletInfo extends StatefulWidget {
  const walletInfo({ Key? key }) : super(key: key);
  @override
  State<walletInfo> createState() => _walletInfoState();
}

class _walletInfoState extends State<walletInfo> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final wallet = Provider.of<Wallet?>(context);
    print('check');
    return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    Color.fromRGBO(7, 15, 87, 1),
                    Color.fromRGBO(80, 178, 200, 1)
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
              child: Column(children: [
                Row(children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Text(
                        '\$',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      )),
                    Text(
                    '${wallet?.amount ?? ''}',
                    style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                  )
                ]),
                Row(
                  children: [
                    SmallWhiteButton(text: 'USD', press: () {}),
                    SmallWhiteButton(text: 'Làm mới', press: () {}),
                    SmallWhiteButton(text: 'Ẩn', press: () {}),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(177, 238, 252, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 5),
                  height: 55,
                  width: size.width * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Center(
                    child: Column(children: [
                      const Text('Xin chào,'),
                      Text(
                        '${wallet?.name}',
                        style: const TextStyle(color: Color.fromRGBO(40, 43, 150, 1)))
                    ]),
                  ),
                )
              ]),
            ),
          );
  }
}

class $ {
}