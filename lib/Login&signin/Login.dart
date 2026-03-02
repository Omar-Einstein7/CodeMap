import 'package:flutter/material.dart';
import 'Signup.dart';
import 'LoginButton.dart';
import 'ForgetPassword.dart';
import 'dart:ui';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    var Formkey =
        GlobalKey<
          FormState
        >(); // use to show error if you don't Write Username or passwoed

    var EmailController =
        TextEditingController(); //Select text inside Username or Email Address Field

    var PasswordController =
        TextEditingController(); //Select text inside Password Field

    bool _obsecureTxt = true;

    return Scaffold(
      backgroundColor: Color(0xff892FE0), //body background color
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),

          child: Form(
            key: Formkey,

            child: Stack(
              children: [
                Align(
                  alignment: Alignment(-2.5, -1.7), // heigh & width in body
                  child: Transform.scale(
                    scale: 1.8, //Size Circle out body
                    child: Container(
                      child: CircleAvatar(
                        radius: 120, // Size Circle
                        backgroundColor: Color(0xff451375), //Color Circle
                      ),
                    ),
                  ),
                ), //Purple Circle

                Align(
                  alignment: Alignment(5, -0.8), // heigh & width in body
                  child: Transform.scale(
                    scale: 1.8, //Size Circle out body
                    child: Container(
                      child: CircleAvatar(
                        radius: 120, // Size Circle
                        backgroundColor: Color(0xffD96DFF), //Color Circle
                      ),
                    ),
                  ),
                ), // pink Circle

                Align(
                  alignment: Alignment(0, 1.7), // heigh & width in body
                  child: Transform.scale(
                    scale: 1.8, //Size Circle out body
                    child: Container(
                      child: ClipRect(
                        child: CircleAvatar(
                          radius: 120, // Size Circle
                          backgroundColor: Colors.white.withOpacity(
                            0.5,
                          ), //Color Circle
                        ),
                      ),
                    ),
                  ),
                ), // White Circle

                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //use to make (Word "Login" & Username or EmailAddress Field & The Password field & LoginButton & ("Dont Have An Account? & Registry") & ("Forget Your Password") In The Middle

                    children: [
                      TitlePage(
                        FTITLE: "Login",
                        fontsize: 65,
                        height: 4,
                      ), //  This is Word "Login"

                      sizeboxbetweentextformfield(SizedBox: 40),

                      EMAILFIELD(
                        EmailController: EmailController,
                        context: context,
                        labelText: "Username or Email Address",
                        THEDIRECTIONTO: Null,
                      ),

                      sizeboxbetweentextformfield(SizedBox: 20),

                      PASSWORDFIELD(
                        context: context,
                        Controller: PasswordController,
                        labelname: "Password",
                        obsecure: _obsecureTxt,
                        DIRECTIONTO: signup(),
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obsecureTxt = !_obsecureTxt;
                            });
                          },
                          child: Icon(
                            _obsecureTxt
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white54,
                          ),
                        ),
                      ),

                      sizeboxbetweentextformfield(SizedBox: 20),

                      DefaultBautton(
                        width: 200, //button width
                        background: Color(0xffC22BB7), //button Color
                        radius: 30, //button Angle
                        function: () {
                          if (Formkey.currentState!.validate()) {
                            print(EmailController);
                            print(PasswordController);
                          } // if the code field empty print error in field
                        },
                        text: 'Login',
                      ), //this is LoginButton

                      sizeboxbetweentextformfield(SizedBox: 5),

                      Row(
                        children: [
                          Text(
                            '       Don\'t have an account ?',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return signup();
                                  },
                                ),
                              );
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
                      ), // This is ("Dont Have An Account? & Registry") & Navigator

                      sizeboxbetweentextformfield(SizedBox: 150),

                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return forgetpassword();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Forget you\'r Password ?",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                        ],
                      ), // This is ("Forget Your Password") & The Navigator
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
