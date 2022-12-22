import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:metro_yatra/select_station.dart';

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
            children: <Widget>[
              DropDownField(
                controller: stationSelected,
                hintText: "select station",
                enabled: true,
                itemsVisibleInDropdown: station.length,
                items: station,
                onValueChanged: (value){
                  setState((){
                    // selectStation = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
