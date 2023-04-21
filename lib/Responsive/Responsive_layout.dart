import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({Key? key, required this.mobile_body, required this.Desktop_body}) : super(key: key);

  final Widget mobile_body;
  final Widget Desktop_body;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_,c){
      if(c.maxWidth < 650){
        return mobile_body;

      }
      else{
        return Desktop_body;

      }

    });
  }
}
