import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Scaffold(
          appBar: SendCoinAppBar(
            widget.amountToCrypto,
            size: size,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sending',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 16),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.fee} ${widget.selectedCrypto}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 26),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.fee * widget.amountToCrypto} USD',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Gửi tới địa chỉ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(150, 227, 244, 1),
                        border: Border.all(
                            color: const Color.fromRGBO(150, 227, 244, 1)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        widget.address,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Fee',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(150, 227, 244, 1),
                        border: Border.all(
                            color: const Color.fromRGBO(150, 227, 244, 1)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.fee} ${widget.selectedCrypto}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.fee * widget.amountToCrypto} USD',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              RoundedPasswordField(
                  passwordController: passwordController,
                  inputTitle: 'Mật khẩu giao dịch',
                  onChanged: (value) {},
                  aToZ: false),
              if (validPassword) const Text('') else const Text('Mật khẩu giao dịch không hợp lệ.'),
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
                    text: 'Gửi',
                    press: () async {
                      final String transactionpPassword =
                          await DatabaseService(uid: _auth.getCurrentUser()!.uid)
                              .getTransactionPassword();
                      if (transactionpPassword != passwordController.text) {
                        setState(() {
                        validPassword = false;
                        });
                      } else {
                        showAlertDialog(context);
                      }
                    },
                    btnWidth: 180,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
