import 'package:flutter/material.dart';
import 'package:infinito_wallet/Screens/Loading/loading.dart';

import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/info_card.dart';
import '../../models/coin_model.dart';
import '../../services/auth.dart';
import '../../services/database.dart';

class BuyCryptoPage extends StatefulWidget {
  const BuyCryptoPage({Key? key, required this.coins}) : super(key: key);

  final List<Coin>? coins;

  @override
  _BuyCryptoPage createState() => _BuyCryptoPage();
}

class _BuyCryptoPage extends State<BuyCryptoPage> {
  // String selectedCurrency = 'USD';
  late Coin? selectedCrypto;
  bool setDefaultCrypto = true;
  dynamic selectedCryptoImg;

  Widget cryptoDropdown() {
    if (setDefaultCrypto) {
      selectedCrypto = widget.coins?.elementAt(0);
      selectedCryptoImg = widget.coins?.elementAt(0).imageUrl;
    }
    return Row(children: [
      Image.network(selectedCryptoImg ?? ''),
      const SizedBox(width: 5,),
      DropdownButton<Coin>(
        borderRadius: BorderRadius.circular(8),
        underline: const SizedBox(),
        value: selectedCrypto,
        items: widget.coins?.map((coin) {
          return DropdownMenuItem(
            value: coin,
            child: Text(coin.symbol.toUpperCase(),),
          );
        }).toList(),
        onChanged: (value) {
          setState(
            () {
              isWaiting = true;
              selectedCrypto = value;
              selectedCryptoImg = value?.imageUrl;
              setDefaultCrypto = false;
            },
          );
          setState(() {
            isWaiting = false;
            amountToCrypto = amountValue / (value?.price ?? 1);
          });
        },
        // dropdownColor: Colors.black,
        style: const TextStyle(color: Color.fromRGBO(28, 149, 214, 1)),
        iconEnabledColor: const Color.fromRGBO(28, 149, 214, 1),
        iconDisabledColor: const Color.fromRGBO(28, 149, 214, 1),
      ),
    ]);
    // return DropdownButton(
    //   borderRadius: BorderRadius.circular(8),
    //   underline: const SizedBox(),
    //   isExpanded: false,
    //   value: selectedCrypto,
    //   items: snapshot.data?.docs.map((value) {
    //     return DropdownMenuItem(
    //       value: value.id,
    //       child: Text(
    //         value.id,
    //       ),
    //     );
    //   }).toList(),
    //   onChanged: (value) async {
    //     setState(
    //       () {
    //         isWaiting = true;
    //         selectedCrypto = value;
    //         setDefaultCrypto = false;
    //       },
    //     );
    //     await getData();
    //     setState(() {
    //       isWaiting = false;
    //       amountToCrypto = amountValue /
    //           double.parse(coinValue[selectedCurrency] ?? '1');
    //     });
    //   },
    //   // dropdownColor: Colors.black,
    //   style: const TextStyle(color: Color.fromRGBO(28, 149, 214, 1)),
    //   iconEnabledColor: const Color.fromRGBO(28, 149, 214, 1),
    //   iconDisabledColor: const Color.fromRGBO(28, 149, 214, 1),
    // );
  }

  // Row currenciesDropdown() {
  //   final List<DropdownMenuItem<String>> dropdownItems = [];
  //   for (final String i in currenciesList) {
  //     final newItem = DropdownMenuItem(
  //       value: i,
  //       child: Text(i),
  //     );
  //     dropdownItems.add(newItem);
  //   }

  //   return Row(children: [
  //     DropdownButton<String>(
  //       value: selectedCurrency,
  //       items: dropdownItems,
  //       style: const TextStyle(color: Colors.deepPurple),
  //       onChanged: (initValue) {
  //         setState(() {
  //           selectedCurrency = initValue!;
  //           amountToCrypto = amountValue / (selectedCrypto?.price ?? 1);
  //         });
  //       },
  //     )
  //   ]);
  // }

  bool isWaiting = false;

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
            .addCoin(selectedCrypto?.symbol ?? 'BTC', amountToCrypto);
        Navigator.pop(context, false);
      },
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: const Text('Xác nhận'),
      content: const Text('Bạn có đồng ý mua Crypto?'),
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
    amountToCrypto = amountValue / (widget.coins?.elementAt(0).price ?? 1);
    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();
  late double amountValue = 0;
  bool _value = false;
  late bool dieukhoan = false;
  late double amountToCrypto =
      amountValue / (widget.coins?.elementAt(0).price ?? 1);
  final AuthService _auth = AuthService();

  // late String currency = 'USD';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const String _title = 'Mua Crypto';
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
                            decoration:const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/USD.png'),
                              ),
                            ),
                          ),
                          const Text('USD'),
                          const VerticalDivider(
                            thickness: 2,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                              child: TextField(
                            onChanged: (value) async {
                              if (value == '') {
                                value = '0';
                              }
                              amountValue = double.parse(value);
                              setState(() {
                                amountToCrypto =
                                    amountValue / (selectedCrypto?.price ?? 1);
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
                          cryptoDropdown(),
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
              const SizedBox(
                height: 20,
              ),
              const WalletInfo(),
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
                  if (_value) {
                    setState(() {
                      dieukhoan = false;
                    });
                    showAlertDialog(context);
                  } else {
                    setState(() {
                      dieukhoan = true;
                    });
                  }
                },
                text: 'Tiếp tục',
              )),
              if (dieukhoan)
                const Center(
                    child: Text(
                  'Bạn chưa đồng ý điều khoản dịch vụ',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ))
              else
                const Text('')
            ],
          ),
        ));
  }
}
