import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';

class StationList extends StatelessWidget {
  const StationList({Key? key}) : super(key: key);

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
                hintText: "select station",
                enabled: true,
                itemsVisibleInDropdown: station.length,
                items: station,
                onValueChanged: (value){
                  Navigator.pop(context, value);
                },
              ),
            ],
          ),
        ),
      ),
    );

  }
}

//String selectStation = "";
final stationSelected = TextEditingController();
List<String> station = [
  "Dwarka",
  "Dwarka Mor"
];
