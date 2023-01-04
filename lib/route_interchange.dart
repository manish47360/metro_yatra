
import 'package:flutter/material.dart';

class RouteInterchange extends StatelessWidget {
  const RouteInterchange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: const [
        Padding(padding: EdgeInsets.only(left: 20)),
        Icon(Icons.directions_walk,color: Colors.black,),
        SizedBox(width: 60,),
        Text("Interchange",style: TextStyle(fontSize: 20),),
      ],
    );
  }
}
