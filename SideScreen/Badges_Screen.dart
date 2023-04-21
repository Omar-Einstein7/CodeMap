import 'package:flutter/material.dart';

class Badges extends StatefulWidget {
  const Badges({Key? key}) : super(key: key);

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      key: _scaffoldkey,
      endDrawer: Drawer(
        child: Column(
          children: [
            SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30 , top: 10 ),
                          child: Text(
                            "CodeMap",style: TextStyle(color: Colors.white ,fontSize: 20),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30 ),
                          child: Text(
                            "CodeMap Group",style: TextStyle(color: Colors.white ,fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AbsorbPointer(
                          absorbing: false,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/Second_Drawer");
                            },
                            child: CircleAvatar(
                              backgroundImage: AssetImage("images/Jarvis.jpeg"),
                              radius: 50,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )

            ),
            Container(height: 1, width: double.infinity,color: Colors.white,),



            ListTile(
              title: Text("History",style: TextStyle(color: Colors.white ,fontSize: 20),),
              trailing: Icon(Icons.history ,color: Colors.white, size: 30,),
              onTap: (){
                Navigator.of(context).pushNamed("/History_Screen");
              },

            ),
            ListTile(
              title: Text("Favourite",style: TextStyle(color: Colors.white ,fontSize: 20),),
              trailing: Icon(Icons.favorite ,color: Colors.white, size: 30,),
              onTap: (){
                Navigator.of(context).pushNamed("/Favourite_Screen");
              },

            ),
            ListTile(
              title: Text("Badges",style: TextStyle(color: Colors.white ,fontSize: 20),),
              trailing: Icon(Icons.badge,color: Colors.white, size: 30,),
              onTap: (){
                Navigator.of(context).pushNamed("/Badges_Screen");
              },

            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 1, width: double.infinity,color: Colors.white,),


          ],) ,
        backgroundColor: Colors.grey.shade500,
      ),
      body: Container(

        height: double.infinity,
        width: double.infinity,
        decoration : BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [

              Colors.purple,
              Colors.purpleAccent,
              Colors.black,
              Colors.black87

            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text("Badges" ,style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),),)
                  ,TextButton(onPressed: (){
                    _scaffoldkey.currentState?.openEndDrawer();
                  },
                    child: ImageIcon(AssetImage("images/dots-menu.png"),color: Colors.white,),)
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 200 ),
                  child: Text("No Badges Here",style: TextStyle(color: Colors.white54 , fontSize: 25),),

                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
