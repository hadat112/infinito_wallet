import 'package:flutter/material.dart';

import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/rounded_dropdown_input.dart';
import '../../components/wallet_info.dart';

class BuyCryptoPage extends StatefulWidget {
  const BuyCryptoPage({Key? key}) : super(key: key);

  @override
  _BuyCryptoPage createState() => _BuyCryptoPage();
}

class _BuyCryptoPage extends State<BuyCryptoPage> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Mua Crypto';
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: size.width * 0.45,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2),
                  ),
                ),
                child: const Align(
                  child: Text(
                    'Tạo đơn hàng',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            RoundedDropdownInput(
              inputTitle: 'Thanh toán bằng Fiat',
              size: size,
              dropdownValue: 'USD',
              locations: const ['USD', 'VND'],
            ),
            RoundedDropdownInput(
              inputTitle: 'Nhận',
              size: size,
              dropdownValue: 'ETH',
              locations: const ['BTN', 'ETH'],
            ),
            const SizedBox(
              height: 20,
            ),
            WalletInfo(
              size: size,
              walletName: 'Infinito Wallet',
              walletAdd: '1acw2sdw1da2wd3sad12aw3d1d',
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Chấp nhận',
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 30,
              width: 30,
              // color: Colors.purple,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/visa.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: _value
                          ? const Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                              size: 15,
                              color: Colors.blue,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('Tôi đồng ý với điều khoản dịch vụ'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: RoundedButton(
              press: () {},
              text: 'Tiếp tục',
            )),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Card(
                color: const Color(0xFFF4F4F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                    Text('Thông tin dịch vụ'),
                    Icon(Icons.arrow_forward_ios)
                  ]),
                ),
              ),
            )
          ],
        ));
  }
}
