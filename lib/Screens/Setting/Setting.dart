// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/SettingWallet/SettingWallet.dart';
import 'package:infinito_wallet/components/circle_icon.dart';
import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Infinito Wallet';
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const [
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
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: const BoxDecoration(
                    border: Border(
                  bottom:
                      BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4)),
                )),
                child: Row(children: [
                  const IconCircle(
                    circleSize: 35,
                    textInside: 'IW',
                    textSize: 12,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Infinito Wallet',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: size.width * 0.46,
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ]),
              ),
            ),
                        const SizedBox(height: 10,),

            RoundedButton(
              press: () {},
              btnWidth: 130,
              btnHeight: 30,
              text: 'Thêm ví',
            ),
            const SizedBox(height: 10,),
            TitleItem(size: size, text: 'Cài đặt vào những mục khác'),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: const BoxDecoration(
                  border: const Border(
                bottom:
                    const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4)),
              )),
              child: Row(children: [
                const Icon(
                  Icons.settings,
                  color: const Color.fromRGBO(90, 195, 240, 1),
                  size: 35,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Cài đặt',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: size.width * 0.58,
                ),
                const Icon(Icons.arrow_forward_ios)
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: const BoxDecoration(
                  border: const Border(
                bottom:
                    const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4)),
              )),
              child: Row(children: [
                const Icon(
                  Icons.menu_outlined,
                  color: const Color.fromRGBO(90, 195, 240, 1),
                  size: 35,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Những mục khác',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: size.width * 0.40,
                ),
                const Icon(Icons.arrow_forward_ios)
              ]),
            ),
            const SizedBox(height: 20,),
            TitleItem(size: size, text: 'Theo dõi chúng tôi'),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),

        );
  }
}

class TitleItem extends StatelessWidget {
  const TitleItem({
    Key? key,
    required this.size,
    required this.text,
  }) : super(key: key);

  final String text;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(214, 246, 253, 1),
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}