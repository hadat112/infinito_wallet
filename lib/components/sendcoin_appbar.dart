import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/auth.dart';


// ignore: prefer_mixin
class SendCoinAppBar extends StatefulWidget with PreferredSizeWidget {
  SendCoinAppBar(this.amountToCrypto,
      {Key? key,
      required this.size,
      this.selectedCrypto = 'ada',
      })
      : super(key: key);

  final Size size;
  final String selectedCrypto;
  final double amountToCrypto;

  @override
  State<SendCoinAppBar> createState() => _SendCoinAppBarState();

  @override
  Size get preferredSize =>  Size.fromHeight(170.h);
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
    if ((split?.length ?? 1) >= 2) {
      for (var i = 0; i < (limitTo ?? split!.length); i++) {
        buffer.write(split![i][0]);
      }
      return buffer.toString().toUpperCase();
    }
    return string ?? '';
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
        preferredSize: Size.fromHeight(170.h),
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
                margin: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: const LinearGradient(colors: <Color>[
                    Color.fromRGBO(7, 15, 87, 1),
                    Color.fromRGBO(80, 178, 200, 1)
                  ]),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.h, right: 20.h),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding:  EdgeInsets.symmetric(vertical: 10.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Row(children: [
                        Container(
                          height: 30.h,
                          width: 30.h,
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$walletName',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                    ),
                    Card(
                      color: const Color.fromRGBO(71, 145, 176, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        height: 37.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 35.h,
                              width: 35.h,
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16.sp),
                                  );
                                }),
                            const SizedBox(width: 2),
                            Container(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Text(
                                widget.selectedCrypto.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: const Color.fromRGBO(255, 255, 255, 0.6),
                                    fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 4.h,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                        future: getData(),
                        builder: (context, snapshot) {
                          amount = snapshot.data?.get('amount').toDouble();
                          return Text(
                            '(${((amount ?? 0) * widget.amountToCrypto).toStringAsFixed(8)} USD)',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                fontSize: 16.sp),
                          );
                        }),
                  ]),
                ),
              );
            }));
  }
}
