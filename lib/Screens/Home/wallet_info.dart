import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  String? selectedCrypto = 'ada';
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
      height: 160.h,
      child: Stack(
        children:[
         Container(
          height: 128.h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Color.fromRGBO(7, 15, 87, 1),
              Color.fromRGBO(80, 178, 200, 1)
            ]),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.h,),
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
                      return Container(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text(
                          pressHide ? '${snapshot.data?.get('amount').toStringAsFixed(9)}' : '*********',
                          style: TextStyle(
                              fontSize: 24.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
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
                          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4),
                          width: 60.h,
                          height: 24.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.white,
                                width: 0.80),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: DropdownButton(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(8),
                                underline: const SizedBox(),
                                value: selectedCrypto,
                                items: snapshot.data?.docs.map((value) {
                                  return DropdownMenuItem(
                                    value: value.id,
                                    child: Text(
                                      value.id.toUpperCase(),
                                      style: TextStyle(fontSize: 12.sp),
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
                      btnWidth: 60,
                      btnHeight: 20,
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
             
            ]),
          ),
        ),
       
         Positioned(
           left: size.width*0.05,
           top: 80.h,
           child:  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInQuart,
                    builder: (BuildContext context, double _val, Widget? child) {
                      return Opacity(
                        opacity: _val,
                        child: Padding(padding: EdgeInsets.only(top: _val*20),
                        child: child,),
                      );
                    },
                    child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(177, 238, 252, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 5),
                  height: 55.h,
                  width: size.width * 0.9,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('Xin chào,',
                      style: TextStyle(fontSize: 12.sp),),
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
                                style:  TextStyle(
                                    color: const Color.fromRGBO(40, 43, 150, 1
                                    ),
                                    fontSize: 12.sp));
                          })
                    ]),
                  ),
                ),
                    ),
         )
        ]
      ),
    );
  }
}