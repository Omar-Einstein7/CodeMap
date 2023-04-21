
import 'package:codemap2/More/About%20Us.dart';
import 'package:codemap2/More/Badges.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../Model/App_Theme.dart';
import '../More/Setings.dart';
import '../Profilelist.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15) ,
                            bottomRight: Radius.circular(15)),
                        color: themeProvider.themeMode().switchcolor
                    ),
                    width: 160,
                    height: 50,
                    child: Center(
                      child: Text("P R O F I L E" , style: TextStyle(
                          fontSize: 19 ,
                          color: Colors.white,

                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.35,
                          height: height *0.16,
                          margin: EdgeInsets.only(top: height * 0.02),
                          child: Stack(
                            children: [
                              Container(

                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: themeProvider.themeData().disabledColor , width: 5)
                                ),
                                child: CircleAvatar(
                                  radius: width * 0.17 ,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage("mobile/Flutter.png"),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                  child: Container(
                                      width: width *0.09,
                                      height: height*0.05,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                     ),
                                      child: Icon(Icons.edit_rounded, color: themeProvider.themeMode().switchcolor,size: width *0.07,)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03,),
              Text("ROADMAP",style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),),
              SizedBox(height: height * 0.01,),
              Text("RoadMap@gmail.com" ,style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),),
              SizedBox(height: height * 0.03,),
              Expanded(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return Badges();
                            }));
                          },
                          child: ProfileListItem(icon:  LineAwesome.medal_solid, text: "Badges",)),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return Settings();
                            }));
                          },
                          child: ProfileListItem(icon:  LineAwesome.cog_solid, text: "Settings",)),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return AboutUs();
                            }));
                          },
                          child: ProfileListItem(icon:  LineAwesome.question_circle, text: "About Us",)),
                      GestureDetector(
                          child: ProfileListItem(icon: LineAwesome.sign_out_alt_solid, text: "Logout",nav: false,)),
                    ],
                  ))
            ],
          ),
        ),

      ) ,
    );
  }
}


