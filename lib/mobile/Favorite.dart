import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/App_Theme.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      color: themeProvider.themeMode().swithbgcolor,
      child:Scaffold(


        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 50,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15) , bottomRight: Radius.circular(15)),
                        color: themeProvider.themeMode().switchcolor
                    ),
                    width: 160,
                    height: 50,
                    child: Center(
                      child: Text("F A V O U R I T E" , style: TextStyle(
                          fontSize: 19 ,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(" NO FAVOURITE YET" ,
                    style: TextStyle(

                        fontWeight: FontWeight.bold
                        ,fontSize: 24),),
                ),
              ),
            ],
          ),
        ),

      ) ,
    );
  }
}
