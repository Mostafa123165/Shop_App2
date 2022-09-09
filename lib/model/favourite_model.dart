class FavouriteModel{
  bool? status ;
  DataFavourite? dataFavourite ;
  FavouriteModel.fromJson(Map<String,dynamic>json){
    status = json["status"] ;
    if(json["data"] != null )
      dataFavourite = json["data"] != null? DataFavourite.fromJson(json["data"]):null ;
    else dataFavourite = null ;
  }
}

class DataFavourite{
  int? currentPage ;
  List<DataProduct>?dataProduct = [] ;

  DataFavourite.fromJson(Map<String,dynamic>json){
    currentPage = json["current_page"] ;
    if(json['data']!= null){
      json['data'].forEach((v) {
        dataProduct!.add(new DataProduct.fromJson(v));
      });
    }
    }
  }


class DataProduct{
  int? id ;
  Product? product ;
  DataProduct.fromJson(Map<String,dynamic>json){
    id = json["id"] ;
    product = Product.fromJson(json["product"]) ;
  }
}

class Product{
  int? id ;
  dynamic price ;
  int? oldPrice ;
  int? discount ;
  String? image   ;
  String? name ;
  String? description ;

  Product.fromJson(Map<String,dynamic>json){
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    description = json["description"];
  }


}

