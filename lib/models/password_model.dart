class PasswordModelData {

  String? email;

  PasswordModelData({
    this.email,
  });
  PasswordModelData.fromJson(Map<String, dynamic> json) {
    email = json["email"]?.toString();
  }
}

class PasswordModel {
  bool? status;
  late String message;
  PasswordModelData? data;

  PasswordModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"].toString();
    data = (json["data"] != null) ? PasswordModelData.fromJson(json["data"]) : null;
  }
}
