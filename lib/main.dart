import 'package:codemap2/Courses/AICourse.dart';
import 'package:codemap2/Courses/BackCourse.dart';
import 'package:codemap2/Courses/DesktopCourse.dart';
import 'package:codemap2/Courses/FrontCourse.dart';
import 'package:codemap2/Courses/MobCourse.dart';
import 'package:codemap2/Login&signin/Login.dart';
import 'package:codemap2/Login&signin/Login2.dart';
import 'package:codemap2/Model/values.dart';
import 'package:codemap2/features/auth/presentation/pages/login_screen.dart';

import 'package:codemap2/mobile/Favorite.dart';
import 'package:codemap2/mobile/Main.dart';
import 'package:codemap2/mobile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Model/App_Theme.dart';
import 'mobile/Courses.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLightTheme = prefs.getBool(Spref.isLight)?? true ;


  runApp(AppStart(isLightTheme: isLightTheme));
}
/////////////////////////////////////////////////////////////////////
class AppStart extends StatelessWidget {
  const AppStart({Key? key, required this.isLightTheme}) : super(key: key);
  final bool isLightTheme;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_)=> ThemeProvider(isLightTheme: isLightTheme)
          ),
        ],
        child: MyApp());
  }
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(

      routes: {
        "Login" :(context)=> Login2(),
        "Main": (context)=> Main(),
        "Courses": (context)=> Courses(),
        "Fav": (context)=> Favourite(),
        "Profile": (context)=> Profile(),

//////////////////////////////////////////////
        "Mobile": (context)=> MobCourse(),
        "Frontend": (context)=> FrontEnd(),
        "Backend": (context)=> BackCourse(),
        "AI": (context)=> AICourse(),
        "Desktop": (context)=> Desktopcourse(),

      },
      debugShowCheckedModeBanner: false,
      home:LoginScreen() ,
    );
  }
}
