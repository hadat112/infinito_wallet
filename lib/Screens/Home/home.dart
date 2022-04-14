import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/SendCrypto/SendCrypto.dart';

import '../../components/bottom_navigation.dart';
import '../../components/circle_button.dart';
import '../../components/small_button.dart';
import '../BuyCrypto/BuyCrypto.dart';
import '../TradeCoin/TradeCoin.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromRGBO(7, 15, 87, 1),
                  Color.fromRGBO(80, 178, 200, 1)
                ]),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 70, left: 20, right: 20),
            child: Column(children: [
              Row(children: [
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      '\$',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    )),
                Container(
                    child: Text(
                  '0.00',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))
              ]),
              Row(
                children: [
                  SmallWhiteButton(text: 'USD', press: () {}),
                  SmallWhiteButton(text: 'Làm mới', press: () {}),
                  SmallWhiteButton(text: 'Ẩn', press: () {}),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(177, 238, 252, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                margin: EdgeInsets.only(top: 5),
                height: 55,
                width: size.width * 0.9,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: Column(children: [
                    Text('Xin chào,'),
                    Text('Ha dat',
                        style: TextStyle(color: Color.fromRGBO(40, 43, 150, 1)))
                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
      body: Table(children: [
        TableRow(children: [
          CircleBtn(
            title: "Nạp-Gửi",
            tap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SendCryptoPage();
              }));
            },
          ),
          CircleBtn(
            title: "Mua Crypto",
            tap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BuyCryptoPage();
              }));
            },
          ),
          CircleBtn(
            title: "Trade Crypto",
            tap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TradeCoinPage();
              }));
            },
          ),
        ]),
        TableRow(children: [
          CircleBtn(
            title: "Tỷ giá",
            tap: () {},
          ),
          CircleBtn(
            title: "Tín hiệu thị trường",
            tap: () {},
          ),
          CircleBtn(
            title: "Tặng thưởng",
            tap: () {},
          ),
        ])
      ]),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
