import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/rounded_dropdown_input.dart';
import '../../components/wallet_info.dart';
import '../../components/white_button.dart';

class TradeCoinPage extends StatelessWidget {
  const TradeCoinPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Giao dịch';
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
                    'Tạo giao dịch',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            RoundedDropdownInput(
              inputTitle: 'Gửi',
              size: size,
              dropdownValue: 'ONT',
              locations: const ['ONT', 'VND'],
            ),
            RoundedDropdownInput(
              inputTitle: 'Nhận',
              size: size,
              dropdownValue: 'ETH',
              locations: const ['BTN', 'ETH'],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Tỷ giá',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(7, 15, 87, 1)),
                      ),
                      Text(
                        '1 ONT ~ 0.00332 ETH',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'Cung cấp bởi',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(7, 15, 87, 1)),
                      ),
                      Text(
                        'Changelly',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            WalletInfo(
              size: size,
              walletName: 'Infinito Wallet',
              walletAdd: '1acw2sdw1da2wd3sad12aw3d1d',
            ),
            const SizedBox(
              height: 20,
            ),
            // RoundedInputField(
            //     onChanged: (value) {}, inputTitle: 'Mật khẩu giao dịch'),
            const SizedBox(
              height: 110,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WhiteButton(
                  text: 'Trở về',
                  press: () {
                    Navigator.pop(context);
                  },
                  textColor: Colors.black,
                  btnWidth: 180,

                ),
                RoundedButton(
                  text: 'Giao dịch ngay',
                  press: () {},
                  btnWidth: 180,
                ),
              ],
            ),
          ],
        ));
  }
}
