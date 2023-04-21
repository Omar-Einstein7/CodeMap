import 'dart:convert';

import 'package:codemap2/Model/Lang.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MobCourse extends StatefulWidget {
  const MobCourse({Key? key}) : super(key: key);

  @override
  State<MobCourse> createState() => _MobCourseState();
}

class _MobCourseState extends State<MobCourse> {
  TextEditingController textController = TextEditingController();
static List LanguageList = [
   "images2/1C#.jpeg",
  "images2/2C++.jpeg",
   "images2/3Css.jpeg",
  "images2/html-5.png",
  "images2/5Java.png",
   "images2/6Javascript.png",
   "images2/7Python.png",
];



  static List<Lang> Display_list = List.from(list);
  static List<Lang> list = [];

  void UpdateList (String value){
    setState(() {
      Display_list = list.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())
      ).toList();
    });
  }
  Future<List<Lang>> getuser() async{
    final response =await http.get(Uri.parse("http://192.168.1.5:3000/languages/"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      list.clear();
      for(var i in data){
        list.add(Lang.fromJson(i));
      }
      return list;
    }else{
      throw Exception(response.statusCode);
    }
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
            title: Text("Mobile"),
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
                                  child: Image.asset("${LanguageList[i]}",
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
                                      Text("${list[i].name}" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold
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

// AnimSearchBar(
//
// width: 400,
// textController: textController,
//
// onSuffixTap: (){
// setState(() {
// textController.clear();
//
// });
//
// }, onSubmitted: (String ) {  } ,
// ),

// ListTile(
// title: Text("${Display_list[i].Name}"),
// leading: Container(
// width: 40,
// height: 40,
// child: Image(image: AssetImage("${Display_list[i].Image}")))
// ),