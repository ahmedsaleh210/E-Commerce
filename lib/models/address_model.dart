class AddressModel {
/*
{
  "status": true,
  "message": null,
  "data": {
    "current_page": 1,
    "data": [
      {
        "id": 482,
        "name": "home",
        "city": "cairo",
        "region": "nasr city",
        "details": "zaker hussein street",
        "notes": "notes",
        "latitude": 30.0616863,
        "longitude": 31.3260088
      }
    ],
    "first_page_url": "https://student.valuxapps.com/api/addresses?page=1",
    "from": 1,
    "last_page": 1,
    "last_page_url": "https://student.valuxapps.com/api/addresses?page=1",
    "next_page_url": null,
    "path": "https://student.valuxapps.com/api/addresses",
    "per_page": 35,
    "prev_page_url": null,
    "to": 1,
    "total": 1
  }
}
*/

  bool? status;
  String? message;
  AddressModelData? data;
  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null) ? AddressModelData.fromJson(json["data"]) : null;
  }
}

class AddressModelData {
/*
{
  "current_page": 1,
  "data": [
    {
      "id": 482,
      "name": "home",
      "city": "cairo",
      "region": "nasr city",
      "details": "zaker hussein street",
      "notes": "notes",
      "latitude": 30.0616863,
      "longitude": 31.3260088
    }
  ],
  "first_page_url": "https://student.valuxapps.com/api/addresses?page=1",
  "from": 1,
  "last_page": 1,
  "last_page_url": "https://student.valuxapps.com/api/addresses?page=1",
  "next_page_url": null,
  "path": "https://student.valuxapps.com/api/addresses",
  "per_page": 35,
  "prev_page_url": null,
  "to": 1,
  "total": 1
}
*/

  int? currentPage;
  List<AddressModelDataData?>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  AddressModelData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });
  AddressModelData.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"]?.toInt();
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <AddressModelDataData>[];
      v.forEach((v) {
        arr0.add(AddressModelDataData.fromJson(v));
      });
      this.data = arr0;
    }
    firstPageUrl = json["first_page_url"]?.toString();
    from = json["from"]?.toInt();
    lastPage = json["last_page"]?.toInt();
    lastPageUrl = json["last_page_url"]?.toString();
    nextPageUrl = json["next_page_url"]?.toString();
    path = json["path"]?.toString();
    perPage = json["per_page"]?.toInt();
    prevPageUrl = json["prev_page_url"]?.toString();
    to = json["to"]?.toInt();
    total = json["total"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["current_page"] = currentPage;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["data"] = arr0;
    }
    data["first_page_url"] = firstPageUrl;
    data["from"] = from;
    data["last_page"] = lastPage;
    data["last_page_url"] = lastPageUrl;
    data["next_page_url"] = nextPageUrl;
    data["path"] = path;
    data["per_page"] = perPage;
    data["prev_page_url"] = prevPageUrl;
    data["to"] = to;
    data["total"] = total;
    return data;
  }
}

class AddressModelDataData {
/*
{
  "id": 482,
  "name": "home",
  "city": "cairo",
  "region": "nasr city",
  "details": "zaker hussein street",
  "notes": "notes",
  "latitude": 30.0616863,
  "longitude": 31.3260088
}
*/

  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  double? latitude;
  double? longitude;

  AddressModelDataData({
    this.id,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
    this.latitude,
    this.longitude,
  });
  AddressModelDataData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    name = json["name"]?.toString();
    city = json["city"]?.toString();
    region = json["region"]?.toString();
    details = json["details"]?.toString();
    notes = json["notes"]?.toString();
    latitude = json["latitude"]?.toDouble();
    longitude = json["longitude"]?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["city"] = city;
    data["region"] = region;
    data["details"] = details;
    data["notes"] = notes;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    return data;
  }
}


