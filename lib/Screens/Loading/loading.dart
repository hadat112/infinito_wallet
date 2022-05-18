import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.size = 50}) : super(key: key);

  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeInOut(
        color:const Color.fromRGBO(7, 15, 87, 1),
        size: size,
      ),
    );
  }
}