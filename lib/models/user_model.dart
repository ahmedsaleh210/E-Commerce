class UserModelData {
/*
{
  "id": 3434,
  "name": "Abdelrahman ALgazzar",
  "email": "algazzar.ali.abdelrahman@gmail.com",
  "phone": "123485678",
  "image": "https://student.valuxapps.com/storage/uploads/users/pB8O0Rnjjj_1631229641.jpeg",
  "points": 0,
  "credit": 0,
  "token": "YGFbuLRKsIWrZcExJf3pqtBaRP0Zz2zq2AcM3fpxaXSdKV2QD2ZgCOlHDzSNaOeCPOvmPS"
}
*/

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserModelData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    name = json["name"]?.toString();
    email = json["email"]?.toString();
    phone = json["phone"]?.toString();
    image = json["image"]?.toString();
    points = json["points"]?.toInt();
    credit = json["credit"]?.toInt();
    token = json["token"]?.toString();
  }
}

class UserModel {
/*
{
  "status": true,
  "message": null,
  "data": {
    "id": 3434,
    "name": "Abdelrahman ALgazzar",
    "email": "algazzar.ali.abdelrahman@gmail.com",
    "phone": "123485678",
    "image": "https://student.valuxapps.com/storage/uploads/users/pB8O0Rnjjj_1631229641.jpeg",
    "points": 0,
    "credit": 0,
    "token": "YGFbuLRKsIWrZcExJf3pqtBaRP0Zz2zq2AcM3fpxaXSdKV2QD2ZgCOlHDzSNaOeCPOvmPS"
  }
}
*/

  bool? status;
  late String message;
  UserModelData? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"].toString();
    data = (json["data"] != null) ? UserModelData.fromJson(json["data"]) : null;
  }
}
