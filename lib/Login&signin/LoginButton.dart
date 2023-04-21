
import 'package:flutter/material.dart';
import 'package:codemap2/Model/Model2.dart';


Widget DefaultBautton ({
  required double width,
  required Color background,
  bool isUpperCase = true,
  double radius =0.0,
  required  function,
  required String text,
}) =>
    Container(

  width: width,
    child: MaterialButton(
      onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
          color: Colors.white,
          fontSize: 20,
      ),
    ),
  ),
      decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(radius,),
        color: background,
      ),
    );



Widget sizeboxbetweentextformfield ({
  required int SizedBox
}) =>
    Container(
      height: SizedBox.toDouble(),
    );





Widget sizeboxTitle ({
  required int SizedBox
}) =>
    Container(
      height: SizedBox.toDouble(),
    );






Widget TitlePage({
  required FTITLE,
  required  fontsize,
  required  height,
  fontwaight

})=> Text(
    FTITLE,style:TextStyle(fontSize:fontsize.toDouble() ,height:height.toDouble(),color: Colors.black, fontWeight: fontwaight));
Widget SubTitlePage({
  required SubTitle,
  required fontsize,

})=>Text(
    SubTitle,style:TextStyle(fontSize:fontsize.toDouble(),color: Colors.black ));









Widget EMAILFIELD({
  required context,
  required labelText,
  required THEDIRECTIONTO,
  required EmailController,


}) =>
    Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
    color: Colors.black54,                    //Field Color
    borderRadius: BorderRadius.circular(14),      //Username Field Angle
    boxShadow:[
      BoxShadow(
          color: Colors.black26,              //shadow color
          blurRadius: 7,                      //Code Field Angle
          offset: Offset(4,4)                //field shadow
      )
    ],                          // Field Shadow
  ),
    height: 60,
      child: TextFormField(
        controller: EmailController,
        onFieldSubmitted:(String value) {
     print(value);
   },    // when press on correct button
        onChanged: (String value) {

     print(value);

   },
        //print all changes in input text
        validator: (value) {
          if (value!.isEmpty) {
            return 'The Username or Email Address Field is Empthy';
          }if(value.contains("@")){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder){
              return THEDIRECTIONTO;
               }));

          }else {
            return 'Please add @';
          }

      },

        style: TextStyle(
       color: Colors.white),                          //Color input text
        decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 14),
        labelText: labelText,                        //Field Name or label Name
        labelStyle: TextStyle(
         color:Colors.white54),                  //stayle Name on Field Or label
        border: InputBorder.none,                 // delete the broder from field or label
        prefixIcon: Icon(
             Icons.email_outlined,
             color: Colors.white54,                    // Icon and color Email icon
   ),
 ),
)
) ;// This is  Username or EmailAddress Field











  Widget PASSWORDFIELD({
    required context,
    required obsecure,
    required suffix,
    required labelname,
    required Controller,
    required DIRECTIONTO
  }) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.black54,                   //Field Color
            borderRadius: BorderRadius.circular(14), //Password Field Angle
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 7, offset: Offset(0, 2))
            ] // Field Shadow
        ),
        height: 60,                                    // height inside field
        child: TextFormField(
          obscureText: obsecure,                      //show text in password field
          controller:Controller,
          //controll in The Text
          onFieldSubmitted: (String value) {
            print(value);
          },     // when press on correct button
          onChanged: (String value) {
            print(value);
          },            //print all changes in input text
          validator: (value) {
            if (value!.isEmpty) {
            return 'Please Enter The Password ';
            } else if (value.contains("@") ) {
             //  Navigator.of(context).push(MaterialPageRoute(builder: (context){
             // return DIRECTIONTO;
             //
             //  }));

            }else{
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return DIRECTIONTO;

              }));
            }

            },                   // if the username field empty print error
          style: TextStyle(color: Colors.white),    //Color input text
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 14),
            labelText: labelname,                         //Name on Field Or label
            labelStyle: TextStyle(
                color: Colors.white54),                   //stayle Name on Field Or label
            prefixIcon: Icon(
              Icons.fingerprint_outlined, color: Colors.white54,),                        // Icon and color Finger icon
            border: InputBorder.none,                     // delete the broder from field or label
            suffixIcon: suffix
          ),
        ),
      ); //this is The Password field











Widget CIRCLES({
  required x,y,
  required ColorCircle
})=> Align(
          alignment:Alignment(x,y),          // heigh & width in body
                child: Transform.scale(scale: 1.8,       //Size Circle out body
                  child: Container(
                  child: CircleAvatar(
                  radius: 120,                     // Size Circle
                  backgroundColor: Color(ColorCircle),// circle color
                  )
                ),
              ),
            );//Purple Circle
