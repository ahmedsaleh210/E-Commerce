class FavoritesModel {
/*
{
  "status": true,
  "message": null,
  "data": {
    "current_page": 1,
    "data": [
      {
        "id": 10475,
        "product": {
          "id": 60,
          "price": 487.5,
          "old_price": 554,
          "discount": 12,
          "image": "https://student.valuxapps.com/storage/uploads/products/1615451948lRQ93.item_XXL_122782705_d77430ea1a334.jpeg",
          "name": "Cressi DE203450 Skylight Silicone Wide-View Anti-UV Unisex Swimming Goggles - Black & Grey",
          "description": "Brand: Cressi\r\nThis mask uses mono-lens technology and the lenses are manufactured with an internal anti-fog treatment that are scratch-resistant and shatterproof.\r\nLenses: Slightly curved for excellent peripheral vision\r\nThe Silicone strap provides a secure and stable fit on the face for long periods in the water.\r\nEasy, adjustable buckle\r\nThe Skylight lenses in the mirrored and tinted version, block out the ultraviolet light, enabling the swimmer to see more clearly."
        }
      }
    ],
    "first_page_url": "https://student.valuxapps.com/api/favorites?page=1",
    "from": 1,
    "last_page": 1,
    "last_page_url": "https://student.valuxapps.com/api/favorites?page=1",
    "next_page_url": null,
    "path": "https://student.valuxapps.com/api/favorites",
    "per_page": 35,
    "prev_page_url": null,
    "to": 10,
    "total": 10
  }
}
*/

  bool? status;
  String? message;
  ModelData? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null) ? ModelData.fromJson(json["data"]) : null;
  }
}

class ModelData {
/*
{
  "current_page": 1,
  "data": [
    {
      "id": 10475,
      "product": {
        "id": 60,
        "price": 487.5,
        "old_price": 554,
        "discount": 12,
        "image": "https://student.valuxapps.com/storage/uploads/products/1615451948lRQ93.item_XXL_122782705_d77430ea1a334.jpeg",
        "name": "Cressi DE203450 Skylight Silicone Wide-View Anti-UV Unisex Swimming Goggles - Black & Grey",
        "description": "Brand: Cressi\r\nThis mask uses mono-lens technology and the lenses are manufactured with an internal anti-fog treatment that are scratch-resistant and shatterproof.\r\nLenses: Slightly curved for excellent peripheral vision\r\nThe Silicone strap provides a secure and stable fit on the face for long periods in the water.\r\nEasy, adjustable buckle\r\nThe Skylight lenses in the mirrored and tinted version, block out the ultraviolet light, enabling the swimmer to see more clearly."
      }
    }
  ],
  "first_page_url": "https://student.valuxapps.com/api/favorites?page=1",
  "from": 1,
  "last_page": 1,
  "last_page_url": "https://student.valuxapps.com/api/favorites?page=1",
  "next_page_url": null,
  "path": "https://student.valuxapps.com/api/favorites",
  "per_page": 35,
  "prev_page_url": null,
  "to": 10,
  "total": 10
}
*/

  int? currentPage;
  List<FavoritesData?>? data;
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

  ModelData.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"]?.toInt();
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <FavoritesData>[];
      v.forEach((v) {
        arr0.add(FavoritesData.fromJson(v));
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
}

class FavoritesData {
/*
{
  "id": 10475,
  "product": {
    "id": 60,
    "price": 487.5,
    "old_price": 554,
    "discount": 12,
    "image": "https://student.valuxapps.com/storage/uploads/products/1615451948lRQ93.item_XXL_122782705_d77430ea1a334.jpeg",
    "name": "Cressi DE203450 Skylight Silicone Wide-View Anti-UV Unisex Swimming Goggles - Black & Grey",
    "description": "Brand: Cressi\r\nThis mask uses mono-lens technology and the lenses are manufactured with an internal anti-fog treatment that are scratch-resistant and shatterproof.\r\nLenses: Slightly curved for excellent peripheral vision\r\nThe Silicone strap provides a secure and stable fit on the face for long periods in the water.\r\nEasy, adjustable buckle\r\nThe Skylight lenses in the mirrored and tinted version, block out the ultraviolet light, enabling the swimmer to see more clearly."
  }
}
*/

  int? id;
  ProductData? product;

  FavoritesData({
    this.id,
    this.product,
  });
  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    product = (json["product"] != null) ? ProductData.fromJson(json["product"]) : null;
  }
}

class ProductData {
/*
{
  "id": 60,
  "price": 487.5,
  "old_price": 554,
  "discount": 12,
  "image": "https://student.valuxapps.com/storage/uploads/products/1615451948lRQ93.item_XXL_122782705_d77430ea1a334.jpeg",
  "name": "Cressi DE203450 Skylight Silicone Wide-View Anti-UV Unisex Swimming Goggles - Black & Grey",
  "description": "Brand: Cressi\r\nThis mask uses mono-lens technology and the lenses are manufactured with an internal anti-fog treatment that are scratch-resistant and shatterproof.\r\nLenses: Slightly curved for excellent peripheral vision\r\nThe Silicone strap provides a secure and stable fit on the face for long periods in the water.\r\nEasy, adjustable buckle\r\nThe Skylight lenses in the mirrored and tinted version, block out the ultraviolet light, enabling the swimmer to see more clearly."
}
*/

  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  ProductData({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });
  ProductData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"]?.toDouble();
    oldPrice = json["old_price"]?.toInt();
    discount = json["discount"]?.toInt();
    image = json["image"]?.toString();
    name = json["name"]?.toString();
    description = json["description"]?.toString();
  }
}





