import 'package:flutter/material.dart';

class desktop_body extends StatelessWidget {
  const desktop_body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("D E S K T O P"),
      ),
      backgroundColor: Colors.deepOrange,

      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.deepOrange[400],

          ),
          Expanded(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(8),
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(
                      color: Colors.deepOrange[400],
                    ),
                  ),),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
