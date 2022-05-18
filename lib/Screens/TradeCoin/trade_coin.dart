import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinito_wallet/components/rounded_button.dart';
import 'package:infinito_wallet/services/auth.dart';
import 'package:infinito_wallet/services/coin_data.dart';

import '../../components/appbar.dart';
import '../../components/info_card.dart';
import '../../components/white_button.dart';
import '../../services/database.dart';
import '../Loading/loading.dart';

class TradeCoinPage extends StatefulWidget {
  const TradeCoinPage({Key? key}) : super(key: key);

  @override
  State<TradeCoinPage> createState() => _TradeCoinPageState();
}

class _TradeCoinPageState extends State<TradeCoinPage> {
  dynamic selectedCrypto;
  dynamic selectedReceiveCrypto;

  bool setDefaultCrypto = true;
  bool setDefaultReceiveCrypto = true;

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
                  selectedCrypto = value;
                  setDefaultCrypto = false;
                },
              );
              await getData();
              await getReceiveData();
              amountToCrypto = double.parse(coinValue['USD'] ?? '1') *
                  amountValue /
                  double.parse(coinReceiveValue['USD'] ?? '1');
              tygia = double.parse(coinValue['USD'] ?? '1') /
                  double.parse(coinReceiveValue['USD'] ?? '1');

              setState(() {
                selectedCrypto = value!;
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
            borderRadius: BorderRadius.circular(8),
            underline: const SizedBox(),
            isExpanded: false,
            value: selectedReceiveCrypto,
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
                  selectedReceiveCrypto = value;
                  setDefaultReceiveCrypto = false;
                },
              );
              await getData();
              await getReceiveData();
              amountToCrypto = double.parse(coinValue['USD'] ?? '1') *
                  amountValue /
                  double.parse(coinReceiveValue['USD'] ?? '1');
              tygia = double.parse(coinValue['USD'] ?? '1') /
                  double.parse(coinReceiveValue['USD'] ?? '1');
              setState(() {
                selectedReceiveCrypto = value!;
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

  Map<String, String> coinValue = {};
  Map<String, String> coinReceiveValue = {};

  bool isWaiting = false;

//  String coinValue = '?';
  Future<void> getData() async {
    try {
      final data = await CoinData().getCoinData(selectedCrypto);
      coinValue = data;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> getReceiveData() async {
    try {
      final data1 = await CoinData().getCoinData(selectedReceiveCrypto);
      coinReceiveValue = data1;
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
        Navigator.pop(context, false);
      },
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
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
    getReceiveData();
    amountToCrypto = double.parse(coinValue['USD'] ?? '1') *
        amountValue /
        double.parse(coinReceiveValue['USD'] ?? '1');
    tygia = double.parse(coinValue['USD'] ?? '1') /
        double.parse(coinReceiveValue['USD'] ?? '1');
        super.initState();
  }

  late double amountValue = 0;
  late double amountToCrypto = double.parse(coinValue['USD'] ?? '1') *
      amountValue /
      double.parse(coinReceiveValue['USD'] ?? '1');
  late double tygia = double.parse(coinValue['USD'] ?? '1') /
      double.parse(coinReceiveValue['USD'] ?? '1');
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Giao dịch';
    return Scaffold(
        appBar: const Appbar(title: _title),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
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
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Gửi',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600))),
                    ),
                    Container(
                      height: 60,
                      width: size.width * 0.9,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            // color: Colors.purple,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(selectedCrypto != null
                                    ? 'assets/$selectedCrypto.png'
                                    : 'assets/BTC.png'),
                              ),
                            ),
                          ),
                          cryptoDropdown(),
                          const VerticalDivider(
                            thickness: 2,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                              child: TextField(
                            onChanged: (value) {
                              if (value == '') {
                                value = '0';
                              }
                              amountValue = double.parse(value);
                              setState(() {
                                amountToCrypto =
                                    double.parse(coinValue['USD'] ?? '1') *
                                        amountValue /
                                        double.parse(
                                            coinReceiveValue['USD'] ?? '1');
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Nhận',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600))),
                    ),
                    Container(
                      height: 60,
                      width: size.width * 0.9,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            // color: Colors.purple,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(selectedCrypto != null
                                    ? 'assets/$selectedReceiveCrypto.png'
                                    : 'assets/BTC.png'),
                              ),
                            ),
                          ),
                          cryptoReceiveDropdown(),
                          const VerticalDivider(
                            thickness: 2,
                          ),
                          const SizedBox(width: 5),
                          if (isWaiting)
                            const Loading(
                              size: 30,
                            )
                          else
                            Text(amountToCrypto.toStringAsFixed(9))
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
                        const Text(
                          'Tỷ giá',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(7, 15, 87, 1)),
                        ),
                        Text(
                          '1 ${selectedCrypto ?? 'BTC'} ~ $tygia ${selectedReceiveCrypto ?? 'BTC'}',
                          style: const TextStyle(
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
              const WalletInfo(),
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
                    press: () {
                      showAlertDialog(context);
                    },
                    btnWidth: 180,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
