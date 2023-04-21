import 'dart:convert';


import 'package:http/http.dart' as http;

import 'Model2.dart';



class apiserv{

  Future<LoginRes> login(LoginReq loginReq)async{
    String uri = "http://localhost:3000/api/users";

    final res = await http.post(Uri.parse(uri) , body: loginReq.toJson());

    if(res.statusCode == 200 || res.statusCode == 400){
      return LoginRes.fromJson(json.decode(res.body));
    }
    else{
      throw Exception("faild");
    }
  }
}