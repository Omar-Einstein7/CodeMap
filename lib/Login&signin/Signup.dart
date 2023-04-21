
import 'Login2.dart';
import 'LoginButton.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var Formkey=GlobalKey<FormState>();
  bool _obsecureText = true;//you can see the password in Password Field
  bool _obsecureTexts = true;//you can see the password in Confirm-Password Field
  var Fname=TextEditingController();
  var Lname=TextEditingController();
  var YouEmail=TextEditingController();
  var Password=TextEditingController();
  var ConfirmPassword=TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    final hight =MediaQuery.of(context).size.height;
    return Container(


      //body background color

      child: Scaffold(
        
        body: Container(
          child: Form(
            key: Formkey,
            child: Stack(
                children: [
                  Container(
                    width: width ,
                    height: hight,
                    child: Image.asset("images/Screenshot 2023-04-07 021535.png" , fit: BoxFit.cover,),
                  ),
                  // white Circle

                SingleChildScrollView(

                   child: Column(
                     children: [
                       SizedBox(height: hight *0.07,),
                       Row(
                         children: [
                           SizedBox(width: width *0.02,),

                           IconButton(onPressed: (){
                             Navigator.pop(context);
                           }, icon: Icon(Icons.arrow_back_ios))
                         ],
                       ),
                       SizedBox(height: hight *0.2,),
                       Container(
                         margin: EdgeInsets.symmetric(horizontal: 15),
                         alignment: Alignment.centerLeft,
                         decoration: BoxDecoration(
                             color: Colors.black54, //Field Color
                             borderRadius:
                             BorderRadius.circular(14), //FirstName Field Angle
                             boxShadow: [
                               BoxShadow(
                                   color: Colors.black26,
                                   blurRadius: 7,
                                   offset: Offset(0, 2))
                             ] // Field Shadow
                         ),
                         height: 60,                    // height inside field
                         child: TextFormField(
                           validator: (value) {
                             if (value!.isEmpty) {
                               return 'Please Enter Firest Name';
                             } else if (value.isNotEmpty) {
                               return null;
                             }
                           },
                           controller: Fname,
                           style:
                           TextStyle(color: Colors.white), //Color input text
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(top: 14),
                             labelText: "First Name", //Name on Field Or label
                             labelStyle: TextStyle(color: Colors.white54
                             ), //stayle Name on Field Or label
                             prefixIcon: Icon(Icons.person_outline, color: Colors.white54
                             ), // Icon and color person icon
                             border: InputBorder.none, // delete the broder from field or label
                           ),
                         ),
                       ), // This is First Name Field

                       sizeboxbetweentextformfield(SizedBox: 20),

                       Container(
                         margin: EdgeInsets.symmetric(horizontal: 15),
                         alignment: Alignment.centerLeft,
                         decoration: BoxDecoration(
                             color: Colors.black54, //Field Color
                             borderRadius:
                             BorderRadius.circular(14), //FirstName Field Angle
                             boxShadow: [
                               BoxShadow(
                                   color: Colors.black26,
                                   blurRadius: 7,
                                   offset: Offset(0, 2))
                             ] // Field Shadow
                         ),
                         height: 60, // height inside field
                         child: TextFormField(
                           controller: Lname,
                           validator: (value) {
                             if (value!.isEmpty) {
                               return 'Please Enter Last Name';
                             } else if (value.isNotEmpty) {
                               return null;
                             }
                           },
                           style:
                           TextStyle(color: Colors.white), //Color input text
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(top: 14),
                             labelText: "Last Name", //Name on Field Or label
                             labelStyle: TextStyle(
                                 color:
                                 Colors.white54), //stayle Name on Field Or label
                             prefixIcon: Icon(
                               Icons.person_outline,
                               color: Colors.white54,
                             ), // Icon and color Person icon
                             border: InputBorder
                                 .none, // delete the broder from field or label
                           ),
                         ),
                       ), // This is Last Name Field

                       sizeboxbetweentextformfield(SizedBox: 20),

                       EMAILFIELD(
                           EmailController: YouEmail,
                           context: context,
                           labelText: "Your Email",
                           THEDIRECTIONTO: Login2()
                       ),

                       sizeboxbetweentextformfield(SizedBox: 20),

                       PASSWORDFIELD(
                         context: context,
                         obsecure: _obsecureText,
                         labelname: "Password",
                         Controller: Password,
                         DIRECTIONTO: Login2(),
                         suffix:GestureDetector(
                           onTap: (){
                             setState(() {
                               _obsecureText =!_obsecureText;
                             });
                           },
                           child: Icon(_obsecureText ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
                         ),
                       ),

                       sizeboxbetweentextformfield(SizedBox : 20),

                       PASSWORDFIELD(
                         context: context,
                         obsecure: _obsecureTexts,
                         labelname: "Confirm-Password",
                         Controller: ConfirmPassword,
                         DIRECTIONTO: Login2(),
                         suffix:GestureDetector(
                           onTap: (){
                             setState(() {
                               _obsecureTexts =!_obsecureTexts;
                             });
                           },
                           child: Icon(_obsecureTexts ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
                         ),
                       ),

                       sizeboxbetweentextformfield(SizedBox: 20),

                       DefaultBautton(
                           width: 200, //button width
                           background: Color(0xff0074B7), // button color
                           radius: 30, // button Angle
                           text: 'Sign up',
                           function: () {
                             if(Formkey.currentState!.validate())
                             {
                               print(Fname);
                               print(Lname);
                               print(YouEmail);
                               print(Password);
                               print(ConfirmPassword);
                             }// if the code field empty print error in field
                           }
                       ),


                       // Signup Button
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
