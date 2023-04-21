class LoginRes{
  final String? token;
  final String? error;

  LoginRes({
    this.token,
    this.error
  });
  factory LoginRes.fromJson(Map<String , dynamic> json){
    return LoginRes(token:  json["token"] != null ? json["token"]: "", error:  json["error"] != null? json["error"]:"");
  }

}

class LoginReq{
  String? email;
  String? pass;

  LoginReq({
    this.email,
    this.pass
  });

  Map<String , dynamic> toJson(){
    Map<String, dynamic> map = {"email" : email?.trim() , "password": pass?.trim()};
    return map;

  }
}
