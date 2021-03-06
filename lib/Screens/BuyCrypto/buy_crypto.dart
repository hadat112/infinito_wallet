import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinito_wallet/Screens/Loading/loading.dart';

import 'package:infinito_wallet/components/rounded_button.dart';

import '../../components/appbar.dart';
import '../../components/info_card.dart';
import '../../models/coin_model.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import '../Home/home.dart';

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
      Image.network(
        selectedCryptoImg ?? '',
      ),
      const SizedBox(
        width: 5,
      ),
      DropdownButton<Coin>(
        borderRadius: BorderRadius.circular(28),
        underline: const SizedBox(),
        iconSize: 18.sp,
        value: selectedCrypto,
        items: widget.coins?.map((coin) {
          return DropdownMenuItem(
            value: coin,
            child: Text(
              coin.symbol.toUpperCase(),
            ),
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
        style: TextStyle(
            color: const Color.fromRGBO(28, 149, 214, 1), fontSize: 12.sp),
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
      child: const Text('Hu???'),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    final Widget continueButton = TextButton(
      child: const Text('?????ng ??'),
      onPressed: () {
        DatabaseService(uid: _auth.getCurrentUser()!.uid)
            .addCoin(selectedCrypto?.symbol ?? 'BTC', amountToCrypto);
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
      title: const Text('X??c nh???n'),
      content: const Text('B???n c?? ?????ng ?? mua Crypto?'),
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
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const Appbar(title: _title),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: size.width * 0.45,
                      margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.only(bottom: 8.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 2),
                        ),
                      ),
                      child: Align(
                        child: Text(
                          'T???o ????n h??ng',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Container(
                      width: size.width * 0.9,
                      margin: EdgeInsets.only(
                        top: 30.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text('B???n mu???n mua v???i bao nhi??u ti???n?',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            height: size.height * 0.06,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromRGBO(0, 0, 0, 0.4)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 30.h,
                                  // color: Colors.purple,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/USD.png'),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'USD',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                const VerticalDivider(
                                  thickness: 2,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                    child: TextField(
                                  style: TextStyle(fontSize: 14.sp),
                                  onChanged: (value) async {
                                    if (value == '') {
                                      value = '0';
                                    }
                                    amountValue = double.parse(value);
                                    setState(() {
                                      amountToCrypto = amountValue /
                                          (selectedCrypto?.price ?? 1);
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
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Container(
                      width: size.width * 0.9,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Nh???n',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600))),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: size.height * 0.06,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromRGBO(0, 0, 0, 0.4)),
                              borderRadius: BorderRadius.circular(50),
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
                                  Text(
                                    amountToCrypto.toStringAsFixed(9),
                                    style: TextStyle(fontSize: 12.sp),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const WalletInfo(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Container(
                      width: size.width * 0.9,
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Ch???p nh???n',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 36),
                    height: 30.h,
                    width: 30.h,
                    // color: Colors.purple,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/visa.png'),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 50,
              // ),
              Column(
                children: [
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
                          width: 20.h,
                          height: 20.h,
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
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'T??i ?????ng ?? v???i ??i???u kho???n d???ch v???',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
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
                    text: 'Ti???p t???c',
                  )),
                  if (dieukhoan)
                    Center(
                        child: Text(
                      'B???n ch??a ?????ng ?? ??i???u kho???n d???ch v???',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    ))
                  else
                    const Text('')
                ],
              ),
            ],
          )),
    );
  }
}
