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
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color.fromRGBO(20, 109, 137, 1),
                Color.fromRGBO(87, 196, 203, 0.37)
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}