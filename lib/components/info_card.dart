import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/auth.dart';
import 'circle_icon.dart';

class WalletInfo extends StatefulWidget {
  const WalletInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  final AuthService _auth = AuthService();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
          width: size.width * 0.9,
        child: Column(

          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Ví',
                      style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600)),
                )),
            Card(
              color: const Color(0xFFF4F4F4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_auth.getCurrentUser()?.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center();
                    }
                    final String name = snapshot.data!.get('wallet_name');
                    return Container(
                      height: size.height*0.06,
                      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          IconCircle(
                            textInside: getInitials(string: name, limitTo: 2),
                            circleSize: size.height*0.06,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp
                                ),
                              ),
                              Text(
                                _auth.getCurrentUser()!.uid,
                                style:  TextStyle(
                                  fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    color: const Color.fromRGBO(7, 15, 87, 1)),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}