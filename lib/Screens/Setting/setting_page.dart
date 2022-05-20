import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/DiffrentSetting/different_setting.dart';
import 'package:infinito_wallet/Screens/Welcome/start_page.dart';
import 'package:infinito_wallet/components/change_name_btn.dart';
import 'package:infinito_wallet/components/circle_icon.dart';
import 'package:infinito_wallet/components/setting_wallet_btn.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/appbar.dart';
import '../../components/bottom_navigation.dart';
import '../../components/rounded_button.dart';
import '../ChangeName/change_name.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();
  String getInitials({String? string, int? limitTo}) {
    final buffer = StringBuffer();
    final split = string?.split(' ');
    if ((split?.length ?? 1) >= 2) {
      for (var i = 0; i < (limitTo ?? split!.length); i++) {
        buffer.write(split![i][0]);
      }
      return buffer.toString().toUpperCase();
    } 
    return string![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Infinito Wallet';
    return Scaffold(
      appBar: const Appbar(title: _title),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.getCurrentUser()?.uid)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center();
            }

            final String name = snapshot.data?.get('name');
            final String walletName = snapshot.data?.get('wallet_name');

            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconCircle(
                        circleSize: 53,
                        textInside: getInitials(string: name, limitTo: 2),
                        textSize: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
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
                SettingWalletButton(
                  walletName: walletName,
                ),
                const SizedBox(
                  height: 10,
                ),

                // RoundedButton(
                //   press: () {},
                //   btnWidth: 130,
                //   btnHeight: 30,
                //   text: 'Thêm ví',
                // ),
                const SizedBox(
                  height: 10,
                ),
                TitleItem(size: size, text: 'Cài đặt và những mục khác'),
                SettingBtn(
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute<dynamic>(builder: (context) {
                      return ChangeName();
                    }));
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Color.fromRGBO(90, 195, 240, 1),
                    size: 35,
                  ),
                  text: 'Cài đặt',
                ),
                SettingBtn(
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute<dynamic>(builder: (context) {
                        return const DifferentSettingPage();
                      }));
                    },
                    icon: const Icon(
                      Icons.menu_outlined,
                      color: Color.fromRGBO(90, 195, 240, 1),
                      size: 35,
                    ),
                    text: 'Những mục khác'),
                const SizedBox(
                  height: 20,
                ),
                TitleItem(size: size, text: 'Theo dõi chúng tôi'),
                RoundedButton(
                  press: () {
                    _auth.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<dynamic>(
                          builder: (context) => const StartPage()),
                      (Route<dynamic> route) => false,
                    );
                    onHome = true;
                    onSetting = false;
                  },
                  text: 'Đăng xuất',
                  btnWidth: 200,
                  btnHeight: 50,
                )
              ],
            );
          }),
      bottomNavigationBar: const BottomNavigation(
      ),
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
