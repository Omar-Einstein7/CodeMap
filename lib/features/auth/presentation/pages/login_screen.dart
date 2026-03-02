import 'package:codemap2/Login&signin/LoginButton.dart';
import 'package:codemap2/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;
    TextEditingController EmailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        // key: Formkey,
        child: Stack(
          children: [
            SizedBox(
              width: width,
              height: hight,
              child: Image.asset(
                "images/Screenshot 2023-04-07 021621.png",
                fit: BoxFit.cover,
              ),
            ),

            Column(
              children: [
                SizedBox(height: hight * 0.25),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: hight * 0.15),
         
                CustomTextfield(
                  labelText: "Email",
                  controller: EmailController,
                  obscureText: false,
                 
                  prefixIcon:Icon(
                        Icons.email_outlined,
                        color: Colors.white54, // Icon and color Email icon
                      ) ,
                  
                  
                ),
                SizedBox(height: 20),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.black54, //Field Color
                    borderRadius: BorderRadius.circular(
                      14,
                    ), //Password Field Angle
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      ),
                    ], // Field Shadow
                  ),
                  height: 60, // height inside field
                  child: TextFormField(
                    // obscureText: _obsecuretext,//show text in password field
                    // controller: PasswordController,
                    //controll in The Text
                    // onFieldSubmitted: (String value) {
                    //   print(value);
                    // },     // when press on correct button
                    // onChanged: (String value) {
                    //   print(value);
                    // },            //print all changes in input text
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please Enter The Password ';
                    //   } else if (value.contains("@") ) {
                    //     //  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    //     // return DIRECTIONTO;
                    //     //
                    //     //  }));

                    //   }else{
                    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                    //       return mobile_body();

                    //     }));
                    //   }

                    // },                   // if the username field empty print error
                    style: TextStyle(color: Colors.white),
                    // onSaved: (input)=> req?.pass = input ,
                    //Color input text
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 14),
                      labelText: "Password",
                      //Name on Field Or label
                      labelStyle: TextStyle(
                        color: Colors.white54,
                      ), //stayle Name on Field Or label
                      prefixIcon: Icon(
                        Icons.fingerprint_outlined,
                        color: Colors.white54,
                      ), // Icon and color Finger icon
                      border: InputBorder
                          .none, // delete the broder from field or label
                      suffixIcon: IconButton(
                        onPressed: () {
                          // setState(() {

                          // });
                        },
                        icon: Icon(Icons.remove_red_eye_sharp),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: hight * 0.05),

                Container(
                  child: DefaultBautton(
                    width: 200, //button width
                    background: Color(0xff0074B7), //button Color
                    radius: 30, //button Angle
                    function: () {
                      // if(validatesave()){
                      //   setState(() {

                      //   });
                      //   print(req?.toJson());

                      // }

                      // if the code field empty print error in field
                    },
                    text: 'Login',
                  ),
                ), //this is LoginButton

                sizeboxbetweentextformfield(SizedBox: 5),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '       Don\'t have an account ?',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return signup();
                          //     },
                          //   ),
                          // );
                        },
                        child: Text(
                          "Registry Now",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // This is ("Dont Have An Account? & Registry") & Navigator
                Container(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return forgetpassword();
                          //     },
                          //   ),
                          // );
                        },
                        child: Text(
                          "Forget you\'r Password ?",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          //   return mobile_body();
                          // }));
                        },
                        child: Text(
                          "As Guest",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
