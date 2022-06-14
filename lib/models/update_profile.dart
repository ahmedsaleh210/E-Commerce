class UpdateProfile {
/*
{
  "status": true,
  "message": "تم التعديل بنجاح",
  "data": {
    "id": 4198,
    "name": "Ahmed Saleh21",
    "email": "ahmed.saleh2121@gmail.com",
    "phone": "01008427049",
    "image": "https://student.valuxapps.com/storage/uploads/users/jhKVcfmsui_1632475609.jpeg",
    "points": 0,
    "credit": 0,
    "token": "A1tfJtSaJeaZ6H6PCwWkF4Ro3cx4PuSrJIhKlkVuuH1cXivbzKAwnqtYiNo2jVLTePQiJW"
  }
}
*/

  bool? status;
  late String message;
  UpdateProfileData? data;

  UpdateProfile.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"].toString();
    data = (json["data"] != null) ? UpdateProfileData.fromJson(json["data"]) : null;
  }
}

class UpdateProfileData {
/*
{
  "id": 4198,
  "name": "Ahmed Saleh21",
  "email": "ahmed.saleh2121@gmail.com",
  "phone": "01008427049",
  "image": "https://student.valuxapps.com/storage/uploads/users/jhKVcfmsui_1632475609.jpeg",
  "points": 0,
  "credit": 0,
  "token": "A1tfJtSaJeaZ6H6PCwWkF4Ro3cx4PuSrJIhKlkVuuH1cXivbzKAwnqtYiNo2jVLTePQiJW"
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

  UpdateProfileData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });
  UpdateProfileData.fromJson(Map<String, dynamic> json) {
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
