import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  CustomTextfield({
    super.key,
    required this.labelText,
    required this.controller,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.black54, //Field Color
        borderRadius: BorderRadius.circular(14), //Password Field Angle
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 7, offset: Offset(0, 2)),
        ], // Field Shadow
      ),
      height: 60,
      child: TextFormField(
        // onSaved: (input)=> req?.email = input ,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 14),
          labelText: labelText, //Field Name or label Name
          labelStyle: TextStyle(
            color: Colors.white54,
          ), //stayle Name on Field Or label
          border: InputBorder.none, // delete the broder from field or label
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),

        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'The Username or Email Address Field is Empthy';
        //   }if(value.contains("@")){
        //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder){
        //       return mobile_body();
        //     }));

        //   }else {
        //     return 'Please add @';
        //   }

        // },
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
