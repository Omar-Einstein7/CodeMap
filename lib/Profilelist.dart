import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Model/App_Theme.dart';

class ProfileListItem extends StatefulWidget{

  final IconData? icon;
  final String? text;
  final bool? nav;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    this.nav = true,
  }) : super (key: key);

  @override
  State<ProfileListItem> createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: height*  0.08,
      margin: EdgeInsets.symmetric(horizontal: 30 , vertical: 8),
      decoration: BoxDecoration(
          color: themeProvider.themeMode().switchcolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          Icon(this.widget.icon , size: 25, color: Colors.white,),
          SizedBox(width: width *0.05,),
          Text("${this.widget.text}", style: TextStyle(fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 17), ),
          Spacer(),
          if(this.widget.nav == true)
            Icon(Icons.arrow_forward_ios , size: 25, color: Colors.white,),
        ],
      ),
    );
  }
}