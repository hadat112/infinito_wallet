import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  }) : super(key: key);

  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double change;
  final double changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 6),
      child: Container(
        padding:  EdgeInsets.symmetric(vertical:12.h, horizontal: 4.w),
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
        // decoration: const BoxDecoration(
        //     border: Border(bottom: BorderSide(color: Colors.grey))),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.network(imageUrl),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            symbol.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                            color:Color.fromRGBO(0, 0, 0, 0.53),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '\$ ${(price.toDouble() * 1000000).round() / 1000000.0}',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      change.toDouble() < 0
                          ? '${(change.toDouble()* 10000000).round() / 10000000.0}'
                          : '+${(change.toDouble()* 10000000).round() / 10000000.0}',
                      style: TextStyle(
                        color: change.toDouble() < 0
                            ? const Color.fromRGBO(215, 13, 13, 1)
                            : const Color.fromRGBO(10, 151, 63, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      changePercentage.toDouble() < 0
                          ? '${(changePercentage.toDouble()* 100000000).round() / 100000000.0}%'
                          : '+${(changePercentage.toDouble()* 100000000).round() / 100000000.0}%',
                      style: TextStyle(
                        color: changePercentage.toDouble() < 0
                            ? const Color.fromRGBO(215, 13, 13, 1)
                            : const Color.fromRGBO(10, 151, 63, 1),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}