import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/sendcoin_appbar.dart';
import '../../components/white_button.dart';
import '../../models/wallet.dart';
import '../../services/auth.dart';
import '../../services/coin_data.dart';
import '../../services/database.dart';
import '../ConfirmSend/ConfirmSend.dart';

class SendCryptoPage extends StatefulWidget {
  SendCryptoPage({Key? key}) : super(key: key);

  @override
  State<SendCryptoPage> createState() => _SendCryptoPageState();
}

class _SendCryptoPageState extends State<SendCryptoPage> {
  String selectedCurrency = 'ADA';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in cryptoList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  Map<String, String> coinValue = {};

  bool isWaiting = false;

//  String coinValue = '?';
  getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      coinValue = data;
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    getData();
  }

  final inputEditingController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final AuthService _auth = AuthService();

  bool change = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamProvider<Wallet?>.value(
      initialData: null,
      value: DatabaseService(uid: _auth.getCurrentUser()!.uid).wallet,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: SendCoinAppBar(size: size),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedInputField(
                      inputEditingController: inputEditingController,
                      inputTitle: 'Gửi tới địa chỉ',
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Số lượng',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Container(
                        height: 60,
                        width: size.width * 0.9,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 0.4)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            androidDropdown(),
                            // const Text(
                            //   'ADA',
                            //   textAlign: TextAlign.right,
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       color: Color.fromRGBO(28, 149, 214, 1),
                            //       fontSize: 18),
                            // ),
                            const VerticalDivider(
                              thickness: 2,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                                child: TextField(
                              controller: amountController,
                              onChanged: (String value) {
                                print(value);
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            )),
                            Text(
                              currenciesList[0] ?? 'null',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 45,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(150, 227, 244, 1),
                          border: Border.all(
                              color: const Color.fromRGBO(150, 227, 244, 1)),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Giao dịch',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 45,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(150, 227, 244, 1)),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tổng',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${amountController.text} ${selectedCurrency}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '0.0073 USD',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(0, 0, 0, 0.5)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      WhiteButton(
                        text: 'Huỷ bỏ',
                        press: () {
                          Navigator.pop(context);
                        },
                        textColor: Colors.black,
                        btnWidth: 180,
                      ),
                      RoundedButton(
                        text: 'Tiếp tục',
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ConfirmSendCryptoPage();
                          }));
                        },
                        btnWidth: 180,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
