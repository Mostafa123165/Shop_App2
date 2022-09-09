class HomeModel {
bool? status ;
Data? data ;

HomeModel.formJson(Map<String , dynamic>json){
  status = json["status"] ;
  data = Data.fromJson(json["data"]);
}
}

class Data {
List<BannerModel>? banners =[] ;
List<ProductModel>? products = [] ;

Data.fromJson(Map<String,dynamic>json){
  json["banners"].forEach((value){
    banners!.add(BannerModel.fromJson(value)) ;
  });

  json["products"].forEach((value){
    products!.add(ProductModel.formJson(value)) ;
  });

}

}

class BannerModel{
 int? id ;
 String? image ;
 BannerModel.fromJson(Map<String , dynamic>json){
   id = json["id"] ;
   image = json["image"] ;
 }

}

class ProductModel{
  int? id ;
  dynamic price ;
  dynamic oldPrice ;
  dynamic discount ;
  String? image ;
  String? name ;
  String? description ;
  bool? inFavorites ;

  ProductModel.formJson(Map<String , dynamic>json){
    id = json["id"] ;
    price = json["price"] ;
    oldPrice = json["old_price"] ;
    discount = json["discount"] ;
    image = json["image"] ;
    name = json["name"] ;
    description = json["description"] ;
    inFavorites = json["in_favorites"] ;
  }

}
