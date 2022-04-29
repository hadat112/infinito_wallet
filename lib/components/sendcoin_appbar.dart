import 'package:flutter/material.dart';

class SendCoinAppBar extends StatelessWidget with PreferredSizeWidget {
  const SendCoinAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: Container(
        margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: const LinearGradient(
              colors: <Color>[
                Color.fromRGBO(7, 15, 87, 1),
                Color.fromRGBO(80, 178, 200, 1)
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white),
                ),
              ),
              child: Row(children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                  ),
                  child: const Center(
                      child: Text(
                    'IW',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Infinito Wallet',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ),
            Card(
              color: const Color.fromRGBO(71, 145, 176, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29),
              ),
              child: Container(
                height: 37,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(90, 195, 240, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40)),
                      ),
                      child: const Center(
                          child: Text(
                        'PW',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '0.321898',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: const Text(
                        'ADA',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '(E 0.000138 ETH)',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  fontSize: 16),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(170);
}
