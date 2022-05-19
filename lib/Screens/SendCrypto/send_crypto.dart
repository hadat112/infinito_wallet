import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Loading/loading.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/sendcoin_appbar.dart';
import '../../components/white_button.dart';
import '../../services/auth.dart';
import '../../services/coin_data.dart';
import '../ConfirmSend/confirm_send.dart';

class SendCryptoPage extends StatefulWidget {
  const SendCryptoPage({Key? key}) : super(key: key);

  @override
  State<SendCryptoPage> createState() => _SendCryptoPageState();
}

class _SendCryptoPageState extends State<SendCryptoPage> {
  String? selectedCrypto = 'BTC';
  double cryptoToCurrency = 0;
  bool setDefaultCrypto = true;
  bool validAddress = true;
  bool validAmount = true;
  StreamBuilder<QuerySnapshot> cryptoDropdown() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.getCurrentUser()?.uid)
            .collection('wallet')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (setDefaultCrypto) {
            selectedCrypto = snapshot.data?.docs[0].id;
          }
          return DropdownButton(
            borderRadius: BorderRadius.circular(8),
            underline: const SizedBox(),
            isExpanded: false,
            value: selectedCrypto,
            items: snapshot.data?.docs.map((value) {
              return DropdownMenuItem(
                value: value.id,
                child: Text(
                  value.id,
                ),
              );
            }).toList(),
            onChanged: (value) async {
              setState(
                () {
                  isWaiting = true;
                  selectedCrypto = value as String?;
                  setDefaultCrypto = false;
                },
              );
              await getData();
              setState(() {
                selectedCrypto = value as String?;
                isWaiting = false;
              });
            },
            // dropdownColor: Colors.black,
            style: const TextStyle(color: Color.fromRGBO(28, 149, 214, 1)),
            iconEnabledColor: const Color.fromRGBO(28, 149, 214, 1),
            iconDisabledColor: const Color.fromRGBO(28, 149, 214, 1),
          );
        });
  }

  Future<DocumentSnapshot<Object?>> getCoinInWallet() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.getCurrentUser()?.uid)
        .collection('wallet')
        .doc(selectedCrypto)
        .get();
  }

  Map<String, String> coinValue = {};

  bool isWaiting = false;

//  String coinValue = '?';
  Future<void> getData() async {
    try {
      final data = await CoinData().getCoinData(selectedCrypto!);
      coinValue = data;
      setState(() {});
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  final inputEditingController = TextEditingController();
  dynamic snapshot;
  Future<bool> checkAddress() async {
    if (inputEditingController.text != '') {
      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(inputEditingController.text)
          .get();
    }

    if (!snapshot.exists) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  final TextEditingController amountController = TextEditingController();

  final AuthService _auth = AuthService();

  late double amountValue = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final amountToUSD = amountValue * double.parse(coinValue['USD'] ?? '0');
    cryptoToCurrency = double.parse(coinValue['USD'] ?? '0');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: SendCoinAppBar(
            cryptoToCurrency,
            size: size,
            selectedCrypto: selectedCrypto ?? 'USD',
          ),
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
                    onChanged: (value) async {
                      validAddress = await checkAddress();
                    }),
                if (validAddress)
                  const Text('')
                else
                  const Text(
                    'Vui lòng nhập địa chỉ hợp lệ',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
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
                                  fontSize: 16, fontWeight: FontWeight.w600))),
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
                          cryptoDropdown(),
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
                          FutureBuilder<DocumentSnapshot>(
                              future: getCoinInWallet(),
                              builder: (context, snapshot) {
                                return Flexible(
                                    child: TextField(
                                  controller: amountController,
                                  onChanged: (String value) {
                                    if (value == '') {
                                      value = '0';
                                    }
                                    if (double.parse(value) <= 0 ||
                                        amountValue >
                                            snapshot.data
                                                ?.get('amount')
                                                .toDouble()) {
                                      validAmount = false;
                                    } else {
                                      validAmount = true;
                                    }
                                    amountValue = double.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  // inputFormatters: <TextInputFormatter>[
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ));
                              }),
                          if (isWaiting)
                            const Loading(
                              size: 30,
                            )
                          else
                            Text(
                              '${amountToUSD.toStringAsFixed(9)} ${currenciesList[0]}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 16),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                if (validAmount)
                  const Text('')
                else
                  const Text(
                    'Vui lòng nhập số lượng hợp lệ',
                    style: TextStyle(
                      color: Colors.red,
                    ),
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
                                '${amountController.text} $selectedCrypto',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${amountToUSD.toStringAsFixed(9)} USD',
                                style: const TextStyle(
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
                  height: 80,
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
                        if (inputEditingController.text == '') {
                          setState(() {
                            validAddress = false;
                          });
                        } else if (amountController.text == '') {
                          setState(() {
                            validAmount = false;
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (context) => ConfirmSendCryptoPage(
                                      selectedCrypto ?? 'BTC',
                                      amountValue,
                                      inputEditingController.text,
                                      cryptoToCurrency)));
                        }
                      },
                      btnWidth: 180,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}