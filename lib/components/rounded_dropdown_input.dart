import 'package:flutter/material.dart';

class RoundedDropdownInput extends StatelessWidget {
  const RoundedDropdownInput({
    Key? key,
    required this.size,
    required this.dropdownValue,
    required this.locations, required this.inputTitle,
  }) : super(key: key);

  final List<String> locations;
  final Size size;
  final String dropdownValue;
  final String inputTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(inputTitle,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
          ),
          Container(
            height: 60,
            width: size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.4)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  // color: Colors.purple,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/usa.png'),
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.expand_more),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? newValue) {
                    // setState(() {
                    //   dropdownValue = newValue!;
                    // });
                  },
                  items:
                      locations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const VerticalDivider(
                  thickness: 2,
                ),
                const SizedBox(width: 5),
                const Flexible(
                    child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
