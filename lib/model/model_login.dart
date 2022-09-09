class ModelLogin{
  bool? status ;
  String? message;
  UserData? data ;

  ModelLogin.formJson(Map<String,dynamic>json){
    status = json["status"] ;
    message =json["message"];
    if(json["data"] != null)
      data = json["data"]!=null? UserData.fromJson(json["data"]) : null ;
    else data = null;
  }
}

class UserData{
  int? id ;
  String? name ;
  String? email ;
  String? phone ;
  String? image ;
  String? token ;
  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
      image=json['image'];
    token=json['token'];
  }
}


