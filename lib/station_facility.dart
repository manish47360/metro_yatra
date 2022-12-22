import 'package:flutter/material.dart';

class Facility extends StatefulWidget {
  const Facility({Key? key}) : super(key: key);

  @override
  State<Facility> createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
      backgroundColor: Colors.blue,
        title: const Text("Station Facilities",),
      centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height * .2,
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: const [
            ],
          ),
        ),
      ),
    );
  }
}
