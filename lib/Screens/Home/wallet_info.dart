import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/small_button.dart';
import '../../services/auth.dart';

class WalletInfo extends StatefulWidget {
  const WalletInfo({Key? key}) : super(key: key);
  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  bool pressHide = true;
  String hideBtnText = 'Ẩn';
  final AuthService _auth = AuthService();
  String? selectedCrypto = 'btc';
  var setDefaultCrypto = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(7, 15, 87, 1),
          Color.fromRGBO(80, 178, 200, 1)
        ]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(children: [
          Row(children: [
            // Container(
            //     margin: const EdgeInsets.only(right: 10),
            //     child: const Text(
            //       '',
            //       style: TextStyle(
            //           fontSize: 24,
            //           color: Colors.white,
            //           fontWeight: FontWeight.w300),
            //     )),
            FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.getCurrentUser()?.uid)
                    .collection('wallet')
                    .doc(selectedCrypto)
                    .get(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center();
                  }
                  return Text(
                    pressHide ? '${snapshot.data?.get('amount').toStringAsFixed(9)}' : '*********',
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  );
                })
          ]),
          Row(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_auth.getCurrentUser()?.uid)
                      .collection('wallet')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (setDefaultCrypto) {
                      // selectedCrypto = snapshot.data?.docs[0].id;
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      width: 73,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.white,
                            width: 0.80),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(8),
                            underline: const SizedBox(),
                            isExpanded: false,
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
                                  selectedCrypto = value as String?;
                                  setDefaultCrypto = false;
                                },
                              );
                            },
                            dropdownColor: Colors.black,
                            style: const TextStyle(color: Colors.white),
                          )),
                    );
                  }),
              SmallWhiteButton(
                  text: hideBtnText,
                  btnWidth: 50,
                  press: () {
                    setState(() {
                      hideBtnText == 'Ẩn'
                          ? hideBtnText = 'Hiện'
                          : hideBtnText = 'Ẩn';
                      pressHide = !pressHide;
                    });
                  }),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(177, 238, 252, 1),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            margin: const EdgeInsets.only(top: 5),
            height: 55,
            width: size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Column(children: [
                const Text('Xin chào,'),
                FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.getCurrentUser()?.uid)
                    .get(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center();
                  }
                      return Text(snapshot.data?.get('email').replaceAll('@gmail.com', ''),
                          style: const TextStyle(
                              color: Color.fromRGBO(40, 43, 150, 1)));
                    })
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
