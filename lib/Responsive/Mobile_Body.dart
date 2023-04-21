
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:codemap2/Model/App_Theme.dart';
import 'package:codemap2/mobile/Courses.dart';
import 'package:codemap2/mobile/Favorite.dart';
import 'package:codemap2/mobile/Main.dart';
import 'package:codemap2/mobile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';





class mobile_body extends StatefulWidget {
  const mobile_body({Key? key}) : super(key: key);

  @override
  State<mobile_body> createState() => _mobile_bodyState();
}

class _mobile_bodyState extends State<mobile_body> {

  int sindex = 0;
  bool x = false;

  List <Widget>body= [
    Main(),
    Courses(),
    Favourite(),
    Profile()

  ];
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    // ThemeProvider themeProvider =Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData(),
      home: Scaffold(
        backgroundColor: themeProvider.themeMode().swithbgcolor,

          floatingActionButton: FloatingActionButton(
            child: Icon(x?Icons.brightness_3:Icons.sunny),
            backgroundColor: themeProvider.themeMode().switchcolor,
            onPressed: () {
              themeProvider.toggleThemeData();
              setState(() {
                x=!x;
              });

            },
            //params
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: [
              Icons.home,
              Icons.lightbulb_outline,
              Icons.favorite_border,
              Icons.person,
            ],
            activeIndex: sindex,
            height: 70,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            backgroundColor: themeProvider.themeMode().switchcolor,
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            onTap: (index) => setState(() => sindex = index),
            //other params
          ),
        body: Center(
          child: body[sindex],
        )
      ),
    );
  }
}
