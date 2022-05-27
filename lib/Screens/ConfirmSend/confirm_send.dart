import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinito_wallet/Screens/Home/home.dart';
import 'package:infinito_wallet/services/database.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_password_field.dart';
import '../../components/sendcoin_appbar.dart';
import '../../components/white_button.dart';
import '../../services/auth.dart';

class ConfirmSendCryptoPage extends StatefulWidget {
  const ConfirmSendCryptoPage(
      this.selectedCrypto, this.fee, this.address, this.amountToCrypto,
      {Key? key})
      : super(key: key);
  final String address;
  final double fee;
  final String selectedCrypto;
  final double amountToCrypto;

  @override
  State<ConfirmSendCryptoPage> createState() => _ConfirmSendCryptoPageState();
}

class _ConfirmSendCryptoPageState extends State<ConfirmSendCryptoPage> {
  bool validPassword = true;

  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();

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
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.address)
            .collection('wallet')
            .doc(widget.selectedCrypto)
            .set({'amount': 0});
        final DocumentReference documentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.address)
            .collection('wallet')
            .doc(widget.selectedCrypto);
        FirebaseFirestore.instance.runTransaction((transaction) async {
          final DocumentSnapshot snapshot =
              await transaction.get(documentReference);
          if (!snapshot.exists) {
            await documentReference.set({'amount': widget.fee});
          }
          final double newAmount = snapshot.get('amount') + widget.fee;
          transaction.update(documentReference, {'amount': newAmount});
        });

        DatabaseService(uid: _auth.getCurrentUser()!.uid)
            .addCoin(widget.selectedCrypto, -widget.fee);
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SendCoinAppBar(
            widget.amountToCrypto,
            size: size,
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  height: constraints.maxHeight,
                  width: size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Gửi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 16.sp),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.fee} ${widget.selectedCrypto.toUpperCase()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 22.sp),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${widget.fee * widget.amountToCrypto} USD',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Gửi tới địa chỉ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 16.sp),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                height: 44.h,
                                width: size.width * 0.9,
                                padding: EdgeInsets.all(4.h),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(150, 227, 244, 1),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            150, 227, 244, 1)),
                                    borderRadius: BorderRadius.circular(28)),
                                child: Center(
                                  child: Text(
                                    widget.address,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Phí',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 16.sp),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                width: size.width * 0.9,
                                padding: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(150, 227, 244, 1),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            150, 227, 244, 1)),
                                    borderRadius: BorderRadius.circular(28)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.fee} ${widget.selectedCrypto.toUpperCase()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      '${widget.fee * widget.amountToCrypto} USD',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.5),
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RoundedPasswordField(
                              passwordController: passwordController,
                              inputTitle: 'Mật khẩu giao dịch',
                              onChanged: (value) {},
                              aToZ: false),
                          if (validPassword)
                            const Text('')
                          else
                            Container(
                                margin: const EdgeInsets.only(left: 22),
                                child: const Text(
                                  'Mật khẩu giao dịch không hợp lệ.',
                                  style: TextStyle(color: Colors.redAccent),
                                )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            text: 'Gửi',
                            singleBtn: false,
                            press: () async {
                              final String transactionpPassword =
                                  await DatabaseService(
                                          uid: _auth.getCurrentUser()!.uid)
                                      .getTransactionPassword();
                              if (transactionpPassword !=
                                  passwordController.text) {
                                setState(() {
                                  validPassword = false;
                                });
                              } else {
                                showAlertDialog(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
