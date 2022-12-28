import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final String trailing;

  const MyCard(this.iconData, this.text, this.trailing, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 2,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(iconData),
            Text(text),
            Text(trailing)
          ]
        ),
      ),
    );
  }
}
