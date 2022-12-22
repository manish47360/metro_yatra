import 'package:flutter/material.dart';

class FirstLastMetro extends StatefulWidget {
  const FirstLastMetro({Key? key}) : super(key: key);

  @override
  State<FirstLastMetro> createState() => _FirstLastMetroState();
}

class _FirstLastMetroState extends State<FirstLastMetro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.blue,
        title: const Text("First Last Metro",),
        centerTitle: true,
      ),
    );
  }
}
