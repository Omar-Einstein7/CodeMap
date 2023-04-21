
import 'package:codemap2/Model/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier{
  bool isLightTheme ;

  getCurrentStatusNavBarColor(){
    if(isLightTheme){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,

      ));
    }else{
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,


      ));
    }
  }

  toggleThemeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(isLightTheme){
      sharedPreferences.setBool(Spref.isLight , false);
      isLightTheme = !isLightTheme;
      notifyListeners();
    }else{
      sharedPreferences.setBool(Spref.isLight, true);
      isLightTheme = !isLightTheme;
      notifyListeners();
    }
    getCurrentStatusNavBarColor();
    notifyListeners();
  }

  ThemeProvider({required this.isLightTheme});

  ThemeData themeData(){
    return ThemeData(
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: isLightTheme? AppColor.bgprimary3 :AppColor.bgsecond3,
      textTheme: TextTheme(

         bodyLarge: TextStyle(
             color: isLightTheme? Colors.black :Colors.white
         )
      )
    );
  }

  ThemeMode themeMode(){
    return ThemeMode(
      switchcolor: isLightTheme? AppColor.primary: AppColor.second,
      thumbcolor:  isLightTheme? AppColor.second2: AppColor.primary2,
      swithbgcolor: isLightTheme? AppColor.bgprimary3: AppColor.bgsecond3,

    );
  }
}

class ThemeMode{
  List<Color>? gradiantcolor;
  Color? switchcolor;
  Color? thumbcolor;
  Color? swithbgcolor;

  ThemeMode({
    this.gradiantcolor,
    this.switchcolor,
    this.thumbcolor,
    this.swithbgcolor
  });

}