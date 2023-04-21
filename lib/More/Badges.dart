import 'package:flutter/material.dart';

class Badges extends StatefulWidget {
  const Badges({Key? key}) : super(key: key);

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child:Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(backgroundColor: Colors.transparent,
          elevation: 1,
          title: Text("B A D G E S"),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.pop(context);},),
        ),
        body: Center(
          child: Text(" NO BADGES YET" ,
            style: TextStyle(color: Colors.white
                ,fontWeight: FontWeight.bold
                ,fontSize: 24),),
        ),
      ),
    );
  }
}
