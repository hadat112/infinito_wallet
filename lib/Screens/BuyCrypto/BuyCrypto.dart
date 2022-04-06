import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/rounded_dropdown_input.dart';
import '../../components/wallet_info.dart';

class BuyCryptoPage extends StatefulWidget {
  @override
  _BuyCryptoPage createState() => _BuyCryptoPage();
}

class _BuyCryptoPage extends State<BuyCryptoPage> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const String _title = "Mua Crypto";
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: size.width * 0.45,
                margin: EdgeInsets.only(top: 30, bottom: 20),
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tạo đơn hàng',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            RoundedDropdownInput(
              inputTitle: 'Thanh toán bằng Fiat',
              size: size,
              dropdownValue: 'USD',
              locations: ['USD', 'VND'],
            ),
            RoundedDropdownInput(
              inputTitle: 'Nhận',
              size: size,
              dropdownValue: 'ETH',
              locations: ['BTN', 'ETH'],
            ),
            SizedBox(
              height: 35,
            ),
            WalletInfo(
              size: size,
              walletName: 'Infinito Wallet',
              walletAdd: '1acw2sdw1da2wd3sad12aw3d1d',
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Chấp nhận',
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 30,
              width: 30,
              // color: Colors.purple,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/visa.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: _value
                          ? Icon(
                              Icons.check,
                              size: 15.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              size: 15.0,
                              color: Colors.blue,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Tôi đồng ý với điều khoản dịch vụ'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: RoundedButton(
              press: () {},
              text: 'Tiếp tục',
            )),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Card(
                color: Color(0xFFF4F4F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
