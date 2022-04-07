import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/rounded_button.dart';
import 'package:infinito_wallet/components/rounded_input_field.dart';

import '../../components/appbar.dart';
import '../../components/rounded_dropdown_input.dart';
import '../../components/wallet_info.dart';
import '../../components/white_button.dart';

class TradeCoinPage extends StatelessWidget {
  const TradeCoinPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = "Giao dịch";
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: size.width * 0.45,
                margin: EdgeInsets.only(top: 40, bottom: 10),
                padding: EdgeInsets.only(bottom: 10),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tạo giao dịch',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            RoundedDropdownInput(
              inputTitle: 'Gửi',
              size: size,
              dropdownValue: 'ONT',
              locations: ['ONT', 'VND'],
            ),
            RoundedDropdownInput(
              inputTitle: 'Nhận',
              size: size,
              dropdownValue: 'ETH',
              locations: ['BTN', 'ETH'],
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
                    children: [
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
                    children: [
                      Text(
                        "Cung cấp bởi",
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
            RoundedInputField(
                onChanged: (value) {}, inputTitle: 'Mật khẩu giao dịch'),
            SizedBox(
              height: size.height * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WhiteButton(
                  text: "Trở về",
                  press: () {
                    Navigator.pop(context);
                  },
                  textColor: Colors.black,
                  btnSize: "S",
                ),
                RoundedButton(
                  text: "Giao dịch ngay",
                  press: () {},
                  btnSize: "S",
                ),
              ],
            ),
          ],
        ));
  }
}
