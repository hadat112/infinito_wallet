import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Loading({Key? key, this.size = 50}) : super(key: key);

  double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color:const Color.fromRGBO(80, 178, 200, 1),
      child: Center(
        child: SpinKitThreeInOut(
          color:Color.fromRGBO(7, 15, 87, 1),
          size: size,
        ),
      ),
    );
  }
}