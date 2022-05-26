import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinito_wallet/components/rounded_button.dart';
import 'package:infinito_wallet/services/auth.dart';

import '../../components/appbar.dart';
import '../../components/info_card.dart';
import '../../components/white_button.dart';
import '../../models/coin_model.dart';
import '../../services/database.dart';
import '../Home/home.dart';
import '../Loading/loading.dart';

class TradeCoinPage extends StatefulWidget {
  const TradeCoinPage({Key? key, this.coins}) : super(key: key);
  final List<Coin>? coins;

  @override
  State<TradeCoinPage> createState() => _TradeCoinPageState();
}

class _TradeCoinPageState extends State<TradeCoinPage> {
  dynamic selectedCrypto;
  double selectedCryptoPrice = 1;
  double selectedReceiveCryptoPrice = 1;

  dynamic selectedReceiveCrypto;

  bool setDefaultCrypto = true;
  bool setDefaultReceiveCrypto = true;
  bool isWaiting = false;
  bool validAmount = true;

  late double amountValue = 0;
  late double amountToCrypto = 1;
  late double tygia = 1;
  final AuthService _auth = AuthService();

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
            borderRadius: BorderRadius.circular(28),
            underline: const SizedBox(),
            value: selectedCrypto,
            items: snapshot.data?.docs.map((value) {
              return DropdownMenuItem(
                value: value.id,
                child: Text(
                  value.id.toUpperCase(),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(
                () {
                  isWaiting = true;
                  selectedCrypto = value;
                  setDefaultCrypto = false;
                },
              );
              getData();

              amountToCrypto = selectedCryptoPrice *
                  amountValue /
                  selectedReceiveCryptoPrice;
              tygia = selectedCryptoPrice / selectedReceiveCryptoPrice;

              setState(() {
                selectedCrypto = value!;
                isWaiting = false;
              });
            },
            iconSize: 18.sp,
            // dropdownColor: Colors.black,
            style:  TextStyle(color: const Color.fromRGBO(28, 149, 214, 1),fontSize: 14.sp),
            iconEnabledColor: const Color.fromRGBO(28, 149, 214, 1),
            iconDisabledColor: const Color.fromRGBO(28, 149, 214, 1),
          );
        });
  }

  StreamBuilder<QuerySnapshot> cryptoReceiveDropdown() {
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
          if (setDefaultReceiveCrypto) {
            selectedReceiveCrypto = snapshot.data?.docs[0].id;
          }
          return DropdownButton(
            borderRadius: BorderRadius.circular(28),
            underline: const SizedBox(),
            value: selectedReceiveCrypto,
            items: snapshot.data?.docs.map((value) {
              return DropdownMenuItem(
                value: value.id,
                child: Text(
                  value.id.toUpperCase(),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(
                () {
                  isWaiting = true;
                  selectedReceiveCrypto = value;
                  setDefaultReceiveCrypto = false;
                },
              );
              getData();

              amountToCrypto = selectedCryptoPrice *
                  amountValue /
                  selectedReceiveCryptoPrice;
              tygia = selectedCryptoPrice / selectedReceiveCryptoPrice;
              setState(() {
                selectedReceiveCrypto = value!;
                isWaiting = false;
              });
            },
            iconSize: 18.sp,
            // dropdownColor: Colors.black,
            style: TextStyle(color: const Color.fromRGBO(28, 149, 214, 1),fontSize: 14.sp),
            iconEnabledColor: const Color.fromRGBO(28, 149, 214, 1),
            iconDisabledColor: const Color.fromRGBO(28, 149, 214, 1),
          );
        });
  }

  void getData() {
    try {
      for (final Coin coin in widget.coins ?? []) {
        if (coin.symbol == selectedCrypto) {
          selectedCryptoPrice = coin.price.toDouble();
        }

        if (coin.symbol == selectedReceiveCrypto) {
          selectedReceiveCryptoPrice = coin.price.toDouble();
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    final Widget cancelButton = TextButton(
      child: const Text('Huỷ'),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    final Widget continueButton = TextButton(
      child: const Text('Đồng ý'),
      onPressed: () {
        DatabaseService(uid: _auth.getCurrentUser()!.uid)
            .addCoin(selectedReceiveCrypto, amountToCrypto);
        DatabaseService(uid: _auth.getCurrentUser()!.uid)
            .addCoin(selectedCrypto, -amountValue);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(builder: (context) => const Home()),
            (route) => false);
      },
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
      title: const Text('Tạo giao dịch'),
      content: const Text('Bạn có đồng ý tạo giao dịch này?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
    amountToCrypto =
        selectedCryptoPrice * amountValue / selectedReceiveCryptoPrice;
    tygia = selectedCryptoPrice / selectedReceiveCryptoPrice;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Giao dịch';
    return SafeArea(
      child: Scaffold(
          appBar: const Appbar(title: _title),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              height: size.height - AppBar().preferredSize.height * 2-24,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: size.width * 0.45,
                          margin: EdgeInsets.only(top: 8.h),
                          padding: EdgeInsets.only(bottom: 8.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 2),
                            ),
                          ),
                          child: Align(
                            child: Text(
                              'Tạo giao dịch',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.9,
                        margin:  EdgeInsets.only(top: 30.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Gửi',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600))),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              height: size.height * 0.06,
                              width: size.width * 0.9,
                              padding:
                                 EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(0, 0, 0, 0.4)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  // Container(
                                  //   height: 30,
                                  //   width: 30,
                                  //   // color: Colors.purple,
                                  //   decoration: BoxDecoration(
                                  //     image: DecorationImage(
                                  //       image: AssetImage(selectedCrypto != null
                                  //           ? 'assets/$selectedCrypto.png'
                                  //           : 'assets/BTC.png'),
                                  //     ),
                                  //   ),
                                  // ),
                                  cryptoDropdown(),
                                  const VerticalDivider(
                                    thickness: 2,
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                      child: TextField(
                                                    style: TextStyle(fontSize: 14.sp),
                                    onChanged: (value) {
                                      if (value == '') {
                                        value = '0';
                                      }
                                      if (double.parse(value) <= 0) {
                                        validAmount = false;
                                      } else {
                                        validAmount = true;
                                      }
                                      amountValue = double.parse(value);
                                      setState(() {
                                        getData();
                                        amountToCrypto = selectedCryptoPrice /
                                            selectedReceiveCryptoPrice;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,),
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
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.9,
                        margin: EdgeInsets.only(top: 25.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Nhận',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600))),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              height: size.height * 0.06,
                              padding:
                                   EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(0, 0, 0, 0.4)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  // Container(
                                  //   height: 30,
                                  //   width: 30,
                                  //   // color: Colors.purple,
                                  //   decoration: BoxDecoration(
                                  //     image: DecorationImage(
                                  //       image: AssetImage(selectedCrypto != null
                                  //           ? 'assets/$selectedReceiveCrypto.png'
                                  //           : 'assets/BTC.png'),
                                  //     ),
                                  //   ),
                                  // ),
                                  cryptoReceiveDropdown(),
                                  const VerticalDivider(
                                    thickness: 2,
                                  ),
                                  SizedBox(width: 5.w),
                                  if (isWaiting)
                                    const Loading(
                                      size: 30,
                                    )
                                  else
                                    Text(amountToCrypto.toStringAsFixed(9), 
                                    style: TextStyle(fontSize: 14.sp),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // RoundedDropdownInput(
                      //   inputTitle: 'Gửi',
                      //   dropdownValue: 'ONT',
                      // ),
                      // RoundedDropdownInput(
                      //   inputTitle: 'Nhận',
                      //   dropdownValue: 'ETH',
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: size.width * 0.9,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 Text(
                                  'Tỷ giá',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: const Color.fromRGBO(7, 15, 87, 1)),
                                ),
                                Text(
                                  '1 ${(selectedCrypto ?? 'ADA').toUpperCase()} ~ ${tygia.toStringAsFixed(9)} ${(selectedReceiveCrypto ?? 'ADA').toUpperCase()}',
                                  style:  TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Cung cấp bởi',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: const Color.fromRGBO(7, 15, 87, 1)),
                                ),
                                Text(
                                  'Changelly',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      const WalletInfo(),

                      // RoundedInputField(
                      //     onChanged: (value) {}, inputTitle: 'Mật khẩu giao dịch'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      WhiteButton(
                        text: 'Trở về',
                        singleBtn: false,
                        press: () {
                          Navigator.pop(context);
                        },
                        textColor: Colors.black,
                        // btnWidth: 180,
                      ),
                      RoundedButton(
                        text: 'Giao dịch ngay',
                        singleBtn: false,
                        press: () {
                          showAlertDialog(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
