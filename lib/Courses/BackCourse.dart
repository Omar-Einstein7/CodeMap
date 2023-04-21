import 'package:flutter/material.dart';

import '../Model/Model.dart';

class BackCourse extends StatefulWidget {
  const BackCourse({Key? key}) : super(key: key);

  @override
  State<BackCourse> createState() => _BackCourseState();
}

class _BackCourseState extends State<BackCourse> {
  TextEditingController textController = TextEditingController();
  static List<Model> LanguageList = [
    Model("C#", "images2/1C#.jpeg"),
    Model("C++", "images2/2C++.jpeg"),
    Model("CSS", "images2/3Css.jpeg"),
    Model("HTML", "images2/html-5.png"),
    Model("Java", "images2/5Java.png"),
    Model("JS", "images2/6Javascript.png"),
    Model("Python", "images2/7Python.png"),
  ];

  static List<Model> Display_list = List.from(LanguageList);
  void UpdateList (String value){
    setState(() {
      Display_list = LanguageList.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())
      ).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("BackEnd"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black45
                  ),
                  child: TextField(

                    onChanged: (value){
                      return UpdateList(value);
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1)
                      ),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Display_list.length == 0 ?Center(
                    child:  Text("NOT FOUND"),
                  ):
                  ListView.builder(
                    itemCount: Display_list.length,
                    itemBuilder: (_,i){
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset("${Display_list[i].image}",
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${Display_list[i].name}" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold
                                          ,color: Colors.white),),
                                      Text("EL ZERO" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold
                                          ,color: Colors.white70),),

                                    ],

                                  ),

                                ),
                                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                              ],
                            ),
                          )
                      );
                    },

                  ),
                )

              ],
            ),
          )),
    );
  }
}
