import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/SettingWallet/SettingWallet.dart';
import 'package:infinito_wallet/components/circle_icon.dart';
import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = "Infinito Wallet";
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  IconCircle(
                    circleSize: 53,
                    textInside: 'QD',
                    textSize: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Quý Dương',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(29, 35, 46, 0.65),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            TitleItem(
              size: size,
              text: 'Ví của tôi',
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingWalletPage();
                    }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    border: Border(
                  bottom:
                      BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
                )),
                child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  IconCircle(
                    circleSize: 35,
                    textInside: 'IW',
                    textSize: 12,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Infinito Wallet',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: size.width * 0.49,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ]),
              ),
            ),
                        SizedBox(height: 10,),

            RoundedButton(
              press: () {},
              btnSize: 'S',
              text: 'Thêm ví',
            ),
                        SizedBox(height: 10,),
            TitleItem(size: size, text: 'Cài đặt vào những mục khác'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                bottom:
                    BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
              )),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.settings,
                  color: Color.fromRGBO(90, 195, 240, 1),
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Infinito Wallet',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: size.width * 0.49,
                ),
                Icon(Icons.arrow_forward_ios)
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                bottom:
                    BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
              )),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.menu_outlined,
                  color: Color.fromRGBO(90, 195, 240, 1),
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Infinito Wallet',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: size.width * 0.49,
                ),
                Icon(Icons.arrow_forward_ios)
              ]),
            ),
            SizedBox(height: 20,),
            TitleItem(size: size, text: 'Theo dõi chúng tôi'),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),

        );
  }
}

class TitleItem extends StatelessWidget {
  final String text;
  const TitleItem({
    Key? key,
    required this.size,
    required this.text,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(214, 246, 253, 1),
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
