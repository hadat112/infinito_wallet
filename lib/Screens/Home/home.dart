import 'package:flutter/material.dart';

import '../../components/bottom_navigation.dart';
import '../../components/circle_button.dart';
import '../../components/small_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color.fromRGBO(20, 109, 137, 1),
                    Color.fromRGBO(87, 196, 203, 0.37)
                  ]),
            ),
          child: Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
                children: [
                Row(
                  children:[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text('\$',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                      ),
                    )
                  ),
                  Container(
                    child: Text('0.00',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
                ]),
                Row(
                  children: [
                    SmallWhiteButton(text: 'USD', press: () {}),
                    SmallWhiteButton(text: 'Làm mới', press: () {}),
                    SmallWhiteButton(text: 'Ẩn', press: () {}),
                  ],
                ),
                
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(177, 238, 252, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 5),
                  height: size.height*0.06,
                  width: size.width*0.9,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(children: [
                    Text('Xin chào,'),
                    Text('Ha dat',
                      style: TextStyle(
                          color: Color.fromRGBO(40, 43, 150, 1)
                      )
                    )
                  ]),
                )
              ]),
          ),
        ),
      ),
      body: Wrap(children: <Widget>[
        CircleBtn(title: "Nạp-Gửi"),
        CircleBtn(title: "Mua Crypto"),
        CircleBtn(title: "Trade Crypto"),
        CircleBtn(title: "Tỷ giá"),
        CircleBtn(title: "Tín hiệu thị trường"),
        CircleBtn(title: "Tặng thưởng"),
      ]),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}