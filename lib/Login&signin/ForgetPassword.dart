import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginButton.dart';
import 'VerfyCodeForgetPassword.dart';

class forgetpassword extends StatelessWidget{

  var emailcontroller=TextEditingController();

  var Formkey=GlobalKey<FormState>();

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
              width: width ,
              height: hight,
              child: Image.asset("images/Screenshot 2023-04-07 021535.png" , fit: BoxFit.cover,),
            ),
            Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children:[

              TitlePage(FTITLE: 'Forgot your Password?',height: 4,fontsize: 30),            //  This is title "Forgot your password"

              SubTitlePage(SubTitle: "Enter your e-mail address to reset your password",fontsize: 16.2),            // This is  "Enter your e-mail address to reset your password"

              sizeboxbetweentextformfield(SizedBox : 30),

              EMAILFIELD(EmailController:emailcontroller,context: context, labelText:"Username or Email Address",THEDIRECTIONTO:VerfyCodeForgetPassword()),      // This is Username or Email Address Field

              sizeboxbetweentextformfield(SizedBox : 30),

              DefaultBautton(
                width: 200,                                   //button width
                background: Color(0xff0074B7),                //button Color
                radius: 30  ,                                 //button Angle
                function: (){
                  if(Formkey.currentState!.validate())
                  {
                    print(emailcontroller);
                  }// if the code field empty print error in field
                  },
                text: 'GO',
              ), //This is Go Button
            ]
          ),
       ]
      ),
      ),
    );
  }

}