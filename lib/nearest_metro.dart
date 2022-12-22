import 'package:flutter/material.dart';

class NearestStation extends StatefulWidget {
  const NearestStation({Key? key}) : super(key: key);

  @override
  State<NearestStation> createState() => _NearestStationState();
}

class _NearestStationState extends State<NearestStation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.blue,
        title: const Text("Nearest Metro Stations",),
        centerTitle: true,
      ),
    );
  }
}
