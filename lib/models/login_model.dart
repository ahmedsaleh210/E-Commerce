class LoginModel
{
  late bool status;
  late String message;
  UserData? data;

  LoginModel.fromJson(Map<String,dynamic> jsonModel)
  {
    status=jsonModel['status'];
    message=jsonModel['message'];
    data = jsonModel['data'] != null ? UserData.fromJson(jsonModel['data']) : null;
  }
}


class UserData
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credits;
  String? token;

  UserData.fromJson(Map<String,dynamic> jsonModel)
  {
    id=jsonModel['id'];
    name=jsonModel['name'];
    email=jsonModel['email'];
    phone=jsonModel['phone'];
    image=jsonModel['image'];
    points=jsonModel['points'];
    credits=jsonModel['credits'];
    token=jsonModel['token'];
  }
}