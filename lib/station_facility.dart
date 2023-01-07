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
        title: const Text(
          "Station Facilities..",
        ),
        centerTitle: true,
      ),
      body: Column(
          //height: MediaQuery.of(context).size.height * .2,
          children: [
            Row(

              children: const [
                Padding(padding: EdgeInsets.only(top: 40)),
                //SizedBox(height: 10,),
                Text(

                  "Contact :",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black87,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: const [
                  Icon(Icons.mobile_friendly_outlined),
                  SizedBox(width: 20),
                  Text("7668024736",style: TextStyle(fontSize: 20),),
                ],),
                Row(children: const [
                  Padding(padding: EdgeInsets.only(left: 60)),
                  Icon(Icons.ice_skating),
                  SizedBox(width: 20,),
                  Text("0123456600",style: TextStyle(fontSize: 20),),
                ],)
              ],
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black87,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: const [
                Text("Gates :",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 2.5,
              color: Colors.black87,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children:const [
                Icon(Icons.door_sliding),
                SizedBox(width: 20,),
                Text("Gate 1",style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Divider(
              thickness: 2.5,
              color: Colors.black87,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children:const [
                Text("Facility :",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),)
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 2.5,
              color: Colors.black87,
            ),
            Row(
              children:const [
                Icon(Icons.add),
                SizedBox(
                  width: 20,
                ),
                Text("Toilet",style: TextStyle(fontSize: 20),)
              ],
            ),
            const Divider(
              thickness: 2.50,
              color: Colors.black87,
            ),
          ]
      ),
    );
  }
}
