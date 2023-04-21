import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../Model/App_Theme.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  List<String> listname= [
    "Recent",
    "mobile",
    "fornt end",
    "back end",
    "AI",
    "games"
  ];
  List<String> mobile= [
    "flutter",
    "kotlin",
    "react",
    "swift",
    "xamariin",
  ];
  List<String> mobileimg= [
    "mobile/Flutter.png",
    "mobile/Kotlin.png",
    "mobile/React.png",
    "mobile/Swift.png",
    "mobile/Xamarin.png",
  ];
  List<String> frontend= [
    "Css",
    "Html",
    "JavaScript",
    "Angular-js",
    "Vue-js",
  ];
  List<String> frontendimg= [
    "frontend/css3.png",
    "frontend/html-5.png",
    "frontend/6Javascript.png",
    "frontend/angularjs.png",
    "frontend/vue-js.png",
  ];
  List<String> backend= [
    "Php",
    "Java",
    "Sql",
    "Node js",
    "Python",
  ];
  List<String> backendimg= [
    "backend/php.png",
    "backend/5Java.png",
    "backend/microsoft-sql-server.png",
    "backend/node-js.png",
    "backend/7Python.png",
  ];
  List<String> Ai= [
    "Java",
    "JavaScript",
    "Python",
    "C++",
  ];
  List<String> Aiimg= [
    "ai/5Java.png",
    "ai/6Javascript.png",
    "ai/7Python.png",
    "ai/c++.png",
  ];
  List images =[
    "images2/c#.png",
    "images2/C++.png",
    "images2/css.png",
    "images2/html-5.png",
    "images2/5Java.png",
    "images2/6Javascript.png",
    "images2/7Python.png",

  ];
  List course =[
    "C #",
    "C + +",
    "C s s",
    "H T M L",
    "J a v a",
    "Java Script",
    "P y t h o n",
  ];
  List<Icon> icon= [
    Icon(BoxIcons.bxl_flutter),
    Icon(BoxIcons.bxl_c_plus_plus),
    Icon(BoxIcons.bxl_css3),
    Icon(BoxIcons.bxl_html5),
    Icon(BoxIcons.bxl_java),
    Icon(BoxIcons.bxl_javascript),
    Icon(BoxIcons.bxl_python),

  ];
  List routecourses =[
    "/coursec#",
    "/coursec",
    "/coursecss",
    "/coursehtml",
    "/coursejava",
    "/coursejs"
  ];
  List  routemob = [
    "/courseflutter",
    "/coursekotlin",
    "/coursereact",
    "/courseswift",
    "/coursexamarin"
  ];

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    width: width,
                    height: height * 0.3,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: width * 0.95,
                          height: height * 0.32,
                        ),
                        Container(
                          height: height * 0.2,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                            color: themeProvider.themeMode().switchcolor,
                              borderRadius: BorderRadius.circular(40)),
                          child: Container(
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.05,),
                                Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "New Trends",
                                      style: TextStyle(
color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Flutter",
                                      style: TextStyle(
color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),

                        ),
                        Positioned(
                          right: 24,
                          child: Container(
                            width: width * 0.6,
                            height: height * 0.25,
                            child: Image.asset(
                              "images2/flutter.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.29,

                    child: ListView.builder(
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (_,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height*0.2,
                            width: width *0.4,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(images[index],),
                              fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(course[index], style: TextStyle(
                                 fontSize: 19 , fontWeight: FontWeight.bold),),
                          ),
                        ],
                      );
                    }),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: width * 0.05,),
                      Text("R E C E N T" , style: TextStyle(

                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),)
                    ],
                  ),
                  Container(
                    height: height * 0.75,
                    width: width ,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                        itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                            leading: Container(
                                child: Image.asset("${images[index]}" , width: 60, height: 70,)),
                            title: Text("${course[index]}" ),
                            subtitle: Text("E L Z E R O" ),



                          ),
                        );
                        }),

                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
