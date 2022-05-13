import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Loading/loading.dart';

import 'package:infinito_wallet/components/rounded_button.dart';
import 'package:provider/provider.dart';

import '../../components/appbar.dart';
import '../../components/wallet_info.dart';
import '../../models/wallet.dart';
import '../../services/auth.dart';
import '../../services/coin_data.dart';
import '../../services/database.dart';

class BuyCryptoPage extends StatefulWidget {
  const BuyCryptoPage({Key? key}) : super(key: key);

  @override
  _BuyCryptoPage createState() => _BuyCryptoPage();
}

class _BuyCryptoPage extends State<BuyCryptoPage> {
  String selectedCurrency = 'USD';
  var selectedCrypto;
  bool setDefaultCrypto = true;

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
                  '${value.id}',
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

  Row currenciesDropdown() {
    final List<DropdownMenuItem<String>> dropdownItems = [];
    for (String i in currenciesList) {
      final newItem = DropdownMenuItem(
        value: i,
        child: Text(i),
      );
      dropdownItems.add(newItem);
    }

    return Row(children: [
      Container(
        height: 30,
        width: 30,
        // color: Colors.purple,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/${selectedCurrency}.png'),
          ),
        ),
      ),
      DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        icon: const Icon(Icons.expand_more),
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (initValue) {
          setState(() async {
            selectedCurrency = initValue!;
            amountToCrypto =
                amountValue / double.parse(coinValue[selectedCurrency] ?? '1');
           await getData();
          });
        },
      )
    ]);
  }

  Map<String, String> coinValue = {};

  bool isWaiting = false;

//  String coinValue = '?';
  getData() async {
    try {
      var data = await CoinData().getCoinData(selectedCrypto);
      coinValue = data;
    } catch (error) {
      print(error);
    }
  }

  void showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Huỷ"),
    onPressed:  () {
      Navigator.pop(context, false);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Đồng ý"),
    onPressed:  () {
    DatabaseService(uid: _auth.getCurrentUser()!.uid).addCoin(selectedCrypto, amountToCrypto);
          Navigator.pop(context, false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Xác nhận"),
    content: const Text("Bạn có đồng ý mua Crypto?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  @override
  void initState() {
    getData();
    amountToCrypto =
        amountValue / double.parse(coinValue[selectedCurrency] ?? '1');
  }

  final TextEditingController textEditingController = TextEditingController();
  late double amountValue = 0;
  bool _value = false;
  late double amountToCrypto =
      amountValue / double.parse(coinValue[selectedCurrency] ?? '1');
  final AuthService _auth = AuthService();

  // late String currency = 'USD';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Mua Crypto';
    return StreamProvider<Wallet?>.value(
      value: DatabaseService(uid: _auth.getCurrentUser()!.uid).wallet,
      initialData: null,
      child: Scaffold(
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
                        'Tạo đơn hàng',
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
                            child: Text('Bạn muốn mua với bao nhiêu tiền',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
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
                            currenciesDropdown(),
                            const VerticalDivider(
                              thickness: 2,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                                child: TextField(
                              onChanged: (value) {
                                if (value == '') value = '0';
                                amountValue = double.parse(value);
                                setState(() {
                                  amountToCrypto = amountValue /
                                      double.parse(
                                          coinValue[selectedCurrency] ?? '1');
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
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
                                  image: AssetImage(
                                    selectedCrypto != null ?
                                      'assets/${selectedCrypto}.png' : 'assets/BTC.png'),
                                ),
                              ),
                            ),
                            cryptoDropdown(),
                            const VerticalDivider(
                              thickness: 2,
                            ),
                            const SizedBox(width: 5),
                            if (isWaiting)
                              Loading(
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
                const SizedBox(
                  height: 20,
                ),
                WalletInfo(),
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
                  height: 80,
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
                  press: () {
                    showAlertDialog(context);
                  },
                  text: 'Tiếp tục',
                )),
                const SizedBox(
                  height: 10,
                ),
                
              ],
            ),
          )),
    );
  }
}
