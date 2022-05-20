import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.symmetric(vertical:12, horizontal: 4),
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
                    padding: const EdgeInsets.only(right: 2),
                    child: Container(
                      height: 50,
                      width: 50,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color:Color.fromRGBO(0, 0, 0, 0.53),
                            fontSize: 14,
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
                    fontSize: 16,
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
                          ? '${(change.toDouble()* 100000000).round() / 100000000.0}'
                          : '+${(change.toDouble()* 100000000).round() / 100000000.0}',
                      style: TextStyle(
                        color: change.toDouble() < 0
                            ? const Color.fromRGBO(215, 13, 13, 1)
                            : const Color.fromRGBO(10, 151, 63, 1),
                        fontSize: 14,
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
                        fontSize: 14,
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