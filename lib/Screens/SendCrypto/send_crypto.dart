import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinito_wallet/Screens/Loading/loading.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/sendcoin_appbar.dart';
import '../../components/white_button.dart';
import '../../models/coin_model.dart';
import '../../services/auth.dart';
import '../../services/coin_data.dart';
import '../ConfirmSend/confirm_send.dart';

class SendCryptoPage extends StatefulWidget {
  const SendCryptoPage({Key? key, this.coins}) : super(key: key);
  final List<Coin>? coins;

  @override
  State<SendCryptoPage> createState() => _SendCryptoPageState();
}

class _SendCryptoPageState extends State<SendCryptoPage> {
  String? selectedCrypto = 'ada';
  dynamic selectedCryptoPrice;

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
            value: selectedCrypto,
            items: snapshot.data?.docs.map((value) {
              return DropdownMenuItem(
                value: value.id,
                child: Text(
                  value.id.toUpperCase(),
                  style: TextStyle(fontSize: 14.sp),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(
                () {
                  isWaiting = true;
                  selectedCrypto = value as String?;
                  setDefaultCrypto = false;
                },
              );
              getData();
              setState(() {
                selectedCrypto = value as String?;
                isWaiting = false;
              });
            },
            iconSize: 18.sp,

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

  // Map<String, String> coinValue = {};

  bool isWaiting = false;

//  String coinValue = '?';
  void getData() {
    try {
      for (final Coin coin in widget.coins ?? []) {
        if (coin.symbol == selectedCrypto) {
          selectedCryptoPrice = coin.price;
        }
      }
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
    getData();
    final size = MediaQuery.of(context).size;
    final amountToUSD = amountValue * selectedCryptoPrice;
    cryptoToCurrency = selectedCryptoPrice.toDouble();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: SendCoinAppBar(
              cryptoToCurrency,
              size: size,
              selectedCrypto: selectedCrypto ?? 'USD',
            ),
            body: Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: 20.h,
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
                        Text(
                          'Vui lòng nhập địa chỉ hợp lệ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red,
                          ),
                        ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: size.width * 0.9,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Số lượng',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600))),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Container(
                              height: size.height * 0.07,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(0, 0, 0, 0.4)),
                                borderRadius: BorderRadius.circular(50),
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
                                          style: TextStyle(fontSize: 14.sp),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.sp),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (validAmount)
                        const Text('')
                      else
                        Text(
                          'Vui lòng nhập số lượng hợp lệ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red,
                          ),
                        ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            height: 45.h,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(150, 227, 244, 1),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(150, 227, 244, 1)),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Giao dịch',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            height: 45.h,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(150, 227, 244, 1)),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tổng',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${amountController.text} ${selectedCrypto?.toUpperCase()}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '${amountToUSD.toStringAsFixed(9)} USD',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.5)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      WhiteButton(
                        text: 'Huỷ bỏ',
                        singleBtn: false,
                        press: () {
                          Navigator.pop(context);
                        },
                        textColor: Colors.black,
                        // btnWidth: 180,
                      ),
                      RoundedButton(
                        text: 'Tiếp tục',
                        singleBtn: false,
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
                                        selectedCrypto ?? 'ada',
                                        amountValue,
                                        inputEditingController.text,
                                        cryptoToCurrency)));
                          }
                        },
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
