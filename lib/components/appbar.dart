import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  const Appbar({
    Key? key,
    required String title,
  }) : _title = title, super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(7, 15, 87, 1),
                Color.fromRGBO(80, 178, 200, 1)
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}