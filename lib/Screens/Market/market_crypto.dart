import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/appbar.dart';
import '../../models/coin_model.dart';
import 'coin_card.dart';

class MarketCrypto extends StatefulWidget {
  const MarketCrypto({
    Key? key,
    required this.coins,
  }) : super(key: key);

  final List<Coin>? coins;

  @override
  State<MarketCrypto> createState() => _MarketCryptoState();
}

class _MarketCryptoState extends State<MarketCrypto> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void addKey() {
    Future<dynamic> ft = Future((){});
    for (int i = 0; i < (widget.coins?.length ?? 0); i++) {
      ft = ft.then((value) {
        return Future.delayed(const Duration(microseconds: 100), () {
      _listKey.currentState?.insertItem(i);
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      addKey();
    });
  }

final Tween<Offset> _offset = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Appbar(
          title: 'Thị trường',
        ),
        body: AnimatedList(
          key: _listKey,
          initialItemCount: widget.coins?.length ?? 1,
          itemBuilder: (context, index, animation) {
            return SlideTransition(
              position: animation.drive(_offset),
              child: CoinCard(
                name: coinList[index].name,
                symbol: coinList[index].symbol,
                imageUrl: coinList[index].imageUrl,
                price: coinList[index].price.toDouble(),
                change: coinList[index].change.toDouble(),
                changePercentage: coinList[index].changePercentage.toDouble(),
              ),
            );
          },
        ));
  }
}