import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:const Color.fromRGBO(80, 178, 200, 1),
      child: const Center(
        child: SpinKitChasingDots(
          color:Color.fromRGBO(7, 15, 87, 1),
        ),
      ),
    );
  }
}