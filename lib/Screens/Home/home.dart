import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Home/wallet_info.dart';
import 'package:infinito_wallet/Screens/SendCrypto/send_crypto.dart';

import '../../components/bottom_navigation.dart';
import '../../components/circle_button.dart';
import '../../models/coin_model.dart';
import '../../services/coin_data.dart';
import '../BuyCrypto/buy_crypto.dart';
import '../Market/market_crypto.dart';
import '../TradeCoin/trade_coin.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.onSignedOut}) : super(key: key);
  final VoidCallback onSignedOut;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Coin>> coinList;
  late CoinData coinData;

  @override
  void initState() {
    coinData = CoinData();
    coinList = coinData.fetchCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(150), child: WalletInfo()),
      body: FutureBuilder<List<Coin>>(
          future: coinList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final List<Coin>? coins = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Table(children: [
                    TableRow(children: [
                      CircleBtn(
                        path: 'assets/send.png',
                        text: 'Nạp-Gửi',
                        tap: () {
                          Navigator.push(context,
                              MaterialPageRoute<dynamic>(builder: (context) {
                            return SendCryptoPage(
                              coins: coins,
                            );
                          }));
                        },
                      ),
                      CircleBtn(
                        path: 'assets/buy.png',
                        text: 'Mua Crypto',
                        tap: () {
                          Navigator.push(context,
                              MaterialPageRoute<dynamic>(builder: (context) {
                            return BuyCryptoPage(coins: coins);
                          }));
                        },
                      ),
                      CircleBtn(
                        path: 'assets/trade.png',
                        text: 'Trade Crypto',
                        tap: () {
                          Navigator.push(context,
                              MaterialPageRoute<dynamic>(builder: (context) {
                            return TradeCoinPage(
                              coins: coins,
                            );
                          }));
                        },
                      )
                    ]),
                    TableRow(children: [
                      // CircleBtn(
                      //   path: 'assets/tygia.png',
                      //   text: 'Tỷ giá',
                      //   tap: () {},
                      // ),

                      CircleBtn(
                        path: 'assets/thitruong.png',
                        text: 'Tín hiệu thị trường',
                        tap: () {
                          Navigator.push(context,
                              MaterialPageRoute<dynamic>(builder: (context) {
                            return MarketCrypto(coins: coins);
                          }));
                        },
                      ),
                      const SizedBox(),
                      const SizedBox(),
                      // CircleBtn(
                      //   path: 'assets/gift.png',
                      //   text: 'Tặng thưởng',
                      //   tap: () {},
                      // )
                    ])
                  ]),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: BottomNavigation(
        onSignedOut: widget.onSignedOut,
      ),
    );
  }
}
