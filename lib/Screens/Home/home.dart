import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = "Xin chào pacman";
    return Scaffold(
      appBar: const Appbar(title: _title),
      body: Wrap(children: <Widget>[
        CircleBtn(title: "Nạp-Gửi"),
        CircleBtn(title: "Mua Crypto"),
        CircleBtn(title: "Trade Crypto"),
        CircleBtn(title: "Tỷ giá"),
        CircleBtn(title: "Tín hiệu thị trường"),
        CircleBtn(title: "Tặng thưởng"),
      ]),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class CircleBtn extends StatelessWidget {
  final String title;
  const CircleBtn({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(children: [
        CircleAvatar(
          radius: 31,
          backgroundColor: const Color(0xFFC4C4C4),
        ),
        Container(
            width: 100,
            child: Align(alignment: Alignment.center, child: Text(title))),
      ]),
    );
  }
}
