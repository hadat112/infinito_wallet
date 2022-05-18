import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class SendCoinAppBar extends StatefulWidget with PreferredSizeWidget {
  SendCoinAppBar(this.amountToCrypto,
      {Key? key,
      required this.size,
      this.selectedCrypto = 'BTC',
      })
      : super(key: key);

  final Size size;
  final String selectedCrypto;
  final double amountToCrypto;

  @override
  State<SendCoinAppBar> createState() => _SendCoinAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(170);
}

class _SendCoinAppBarState extends State<SendCoinAppBar> {
  final AuthService _auth = AuthService();
  double? amount;
  String? walletName;
  String? initialsName;
  double? usdToCrypto;

  @override
  void initState() {
    super.initState();
  }

  String getInitials({String? string, int? limitTo}) {
    final buffer = StringBuffer();
    final split = string?.split(' ');
    for (var i = 0; i < (limitTo ?? split!.length); i++) {
      buffer.write(split?[i][0]);
    }
    return buffer.toString().toUpperCase();
  }

  Future<DocumentSnapshot<Object?>> getData() async {
   return FirebaseFirestore.instance
                            .collection('users')
                            .doc(_auth.getCurrentUser()?.uid)
                            .collection('wallet')
                            .doc(widget.selectedCrypto)
                            .get();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.getCurrentUser()?.uid)
                .get(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return const Center();
              }
              walletName = snapshot.data?.get('wallet_name');
              initialsName = getInitials(string: walletName, limitTo: 2);
              return Container(
                margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: const LinearGradient(colors: <Color>[
                    Color.fromRGBO(7, 15, 87, 1),
                    Color.fromRGBO(80, 178, 200, 1)
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Row(children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40)),
                          ),
                          child: Center(
                              child: Text(
                            initialsName ?? '',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$walletName',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                    ),
                    Card(
                      color: const Color.fromRGBO(71, 145, 176, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Container(
                        height: 37,
                        width: widget.size.width * 0.52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(90, 195, 240, 1),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                    topLeft: Radius.circular(40),
                                    bottomLeft: Radius.circular(40)),
                              ),
                              child: Center(
                                  child: Text(
                                initialsName ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )),
                            ),
                            const SizedBox(width: 10),
                            FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_auth.getCurrentUser()?.uid)
                                    .collection('wallet')
                                    .doc(widget.selectedCrypto)
                                    .get(),
                                builder: (context, snapshot) {
                                  amount =
                                      snapshot.data?.get('amount').toDouble();
                                  return Text(
                                    '${amount?.toStringAsFixed(9)} ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16),
                                  );
                                }),
                            const SizedBox(width: 2),
                            Container(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                widget.selectedCrypto,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(255, 255, 255, 0.6),
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                        future: getData(),
                        builder: (context, snapshot) {
                          amount = snapshot.data?.get('amount').toDouble();
                          return Text(
                            '(${((amount ?? 0) * widget.amountToCrypto).toStringAsFixed(8)} USD)',
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                fontSize: 16),
                          );
                        }),
                  ]),
                ),
              );
            }));
  }
}
