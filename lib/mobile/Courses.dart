

import 'package:codemap2/Courses/AICourse.dart';
import 'package:codemap2/Courses/BackCourse.dart';
import 'package:codemap2/Courses/DesktopCourse.dart';
import 'package:codemap2/Courses/FrontCourse.dart';
import 'package:codemap2/Courses/MobCourse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/App_Theme.dart';
import '../More/Badges.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: themeProvider.themeMode().swithbgcolor,
      child:Scaffold(

        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Row(

                children: [

                  SizedBox(width: 35,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15) , bottomRight: Radius.circular(15)),
                      color: themeProvider.themeMode().switchcolor
                    ),
                    width: width * 0.35,
                    height: height *0.059,
                    child: Center(
                      child: Text("C O U R S E S" , style: TextStyle(
                        fontSize: 19 ,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),

              Expanded(
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(5),
                  crossAxisCount: 2,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return MobCourse();
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: themeProvider.themeMode().switchcolor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 3 , color: Colors.black)
                      ),
                      width: width * 0.2,
                      height: height * 0.3,
                      child: Center(
                        child: Text("M O B I L E" , style: TextStyle(fontSize: 20 ,
                            fontWeight: FontWeight.bold ,
                        ),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return FrontEnd();
                      }));


                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: themeProvider.themeMode().switchcolor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 3 , color: Colors.black)
                      ),
                      width: width * 0.2,
                      height: height * 0.3,
                      child: Center(
                        child: Text("F R O N T E N D" , style: TextStyle(fontSize: 20 ,
                            fontWeight: FontWeight.bold ,
                            ),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return BackCourse();
                        }));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: themeProvider.themeMode().switchcolor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 3 , color: Colors.black)
                      ),
                      width: width * 0.2,
                      height: height * 0.3,
                      child: Center(
                        child: Text("B A C K E N D" , style: TextStyle(fontSize: 20 ,
                            fontWeight: FontWeight.bold ,
                            ),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return AICourse();
                        }));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(color:themeProvider.themeMode().switchcolor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 3 , color: Colors.black)
                      ),
                      width: width * 0.2,
                      height: height * 0.3,
                      child: Center(
                        child: Text("A I" , style: TextStyle(fontSize: 20 ,
                            fontWeight: FontWeight.bold ,
                            ),),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return Desktopcourse();
                        }));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: themeProvider.themeMode().switchcolor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 3 , color: Colors.black)
                      ),
                      width: width * 0.2,
                      height: height * 0.3,
                      child: Center(
                        child: Text("D E S K T O P" , style: TextStyle(fontSize: 20 ,
                            fontWeight: FontWeight.bold ,
                            ),),
                      ),
                    ),
                  ),

                ],),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
