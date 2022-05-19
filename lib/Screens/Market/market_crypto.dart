import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/appbar.dart';
import '../../models/coin_model.dart';
import 'coin_card.dart';

class MarketCrypto extends StatelessWidget {
  const MarketCrypto({
    Key? key,
    required this.coins,
  }) : super(key: key);

  final List<Coin>? coins;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Appbar(
          title: 'Thị trường',
        ),
        body: ListView.builder(
          itemCount: coins?.length,
          itemBuilder: (context, index) {
            return CoinCard(
              name: coinList[index].name,
              symbol: coinList[index].symbol,
              imageUrl: coinList[index].imageUrl,
              price: coinList[index].price.toDouble(),
              change: coinList[index].change.toDouble(),
              changePercentage: coinList[index].changePercentage.toDouble(),
            );
          },
        ));
  }
}