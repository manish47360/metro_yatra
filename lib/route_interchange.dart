
import 'package:flutter/material.dart';

class RouteInterchange extends StatelessWidget {
  const RouteInterchange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: const [
        Padding(padding: EdgeInsets.only(left: 10)),
        Icon(Icons.directions_walk,color: Colors.black,),
        SizedBox(width: 20,),
        Text("Interchange",style: TextStyle(fontSize: 20),),
      ],
    );
  }
}
