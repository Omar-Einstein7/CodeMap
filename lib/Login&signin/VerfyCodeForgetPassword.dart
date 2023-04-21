import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginButton.dart';
import 'NewPassword.dart';
class VerfyCodeForgetPassword extends StatelessWidget{

  var NumberCode=TextEditingController();


  var Formkey=GlobalKey<FormState>();

  List num = [0,1,2,3,4,5,6,7,8,9];
  bool containall(List x  ,int y ){
    for(int i = 0 ;i < x.length ; i++){
      if( y == x[i])
      {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    final hight =MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff892FE0),
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

              TitlePage(FTITLE: 'Change Your Password',height: 6,fontsize: 30 ,fontwaight: FontWeight.w500
              ),              //  This is title "Change your password"

              SubTitlePage(SubTitle: "Check Your Mail To Verfy Code",fontsize: 17
              ),           //  This is title "Check your mail to verfy code"

              sizeboxbetweentextformfield(SizedBox:30),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.black54,                    //Field Color
                    borderRadius: BorderRadius.circular(20),  //Code Field Angle
                    boxShadow:[
                      BoxShadow(
                          color: Colors.black26,             //color shadow
                          blurRadius: 7,                     // blur
                          offset: Offset(0,2)                // shadow direction
                      )
                    ]                           //field shadow
                ),
                height: 60,                       // height inside field
                child: TextFormField(
                  controller: NumberCode,               //controll in The Text
                  keyboardType: TextInputType.number,   //Type Keyboard when press on username field
                  onFieldSubmitted:(String value) {
                    print(value);
                  },// when press on submit button in keyboard
                  onChanged: (String value) {
                    print(value);
                  },      //print all changes input text
                  validator: (value) {
                    if (value!.isEmpty)
                    {
                      return 'Please Enter The Code';

                      }
                    var x=int.parse(value);
                    if(containall(num,x)){

                      Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                        return NewPassword();
                      }));

                    }else{

                      return 'Please Enter Number';
                    }
                  },          // if the username field empty print error
                  style: TextStyle(color: Colors.white
                  ),                //Color input text
                  decoration: InputDecoration(
                    labelText: "Code",                  //Field Name or label Name
                    labelStyle: TextStyle(color:Colors.white54
                    ),         //stayle Name on Field Or label
                    border: InputBorder.none,           // delete the broder from field or label
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.white54
                    ),              // Icon and color Email icon
                  ),
                ),
              ),      // This is Code Field

              sizeboxbetweentextformfield(SizedBox: 30),

              DefaultBautton(
                width: 200,                   //button width
                background: Color(0xff0074B7),//button color
                radius: 30  ,                 //button angle
                function: () {
                  if (Formkey.currentState!.validate()){
                    print(NumberCode);
                  }     // if the code field empty print error in field

                  },
                text: 'GO',
              ), //this is Go Button
            ],
          ),
          ]
        ),
      ),
    );
  }

}