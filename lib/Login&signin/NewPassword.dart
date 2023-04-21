
import 'package:flutter/material.dart';

import 'Login2.dart';
import 'LoginButton.dart';

class NewPassword extends StatefulWidget{

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var Formkey=GlobalKey<FormState>();

  var Fpass=TextEditingController();

  var Spass=TextEditingController();

  bool _obsecureText=true;

  bool _obsecureTexts=true;

  var isPassword=true;

  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    final hight =MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: Formkey,
        child: Stack(
            children:[
              Container(
                width: width,
                height: hight,
                child: Image.asset("images/Screenshot 2023-04-07 021621.png", fit: BoxFit.cover,),

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  TitlePage(FTITLE: 'Change your Password',fontsize: 30,height: 5),            //  "This is title "Change your password"

                  SubTitlePage(SubTitle: "Enter your New Password",fontsize: 16.2),            // "This is title "Enter your New Password"
                  sizeboxbetweentextformfield(SizedBox:30),
                  PASSWORDFIELD(
                    Controller: Fpass,
                      context: context,
                      obsecure: _obsecureText,
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obsecureText =!_obsecureText;
                          });
                        },
                        child: Icon(_obsecureText ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
                      ),
                      labelname: "Password",
                      DIRECTIONTO: Login2()
                  ),

                  sizeboxbetweentextformfield(SizedBox:20),

                  PASSWORDFIELD(
                      Controller: Spass,
                      context: context,
                      obsecure: _obsecureTexts,
                      suffix: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obsecureTexts =!_obsecureTexts;
                          });
                        },
                        child: Icon(_obsecureTexts ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
                      ),
                      labelname: "Confirm-Password",
                      DIRECTIONTO: Login2()
                  ),

                  sizeboxbetweentextformfield(SizedBox:20),

                  DefaultBautton(
                    width: 200,                    //button width
                    background: Color(0xff0074B7
                    ),        //button Color
                    radius: 30  ,                  //button Angle
                    function: () {
                      if(Formkey.currentState!.validate())
                      {
                        print(Fpass);
                        print(Spass);
                      }// if the code field empty print error in field
                      },
                    text: 'Go',
                  ),  //This is GO
                ],
              ),
            ]
        ),
      ),
    );
  }
}