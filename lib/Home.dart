import 'package:codemap2/Responsive/Desktop_Body.dart';
import 'package:codemap2/Responsive/Mobile_Body.dart';
import 'package:codemap2/Responsive/Responsive_layout.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Responsive(mobile_body:  mobile_body(), Desktop_body: desktop_body());
  }
}
