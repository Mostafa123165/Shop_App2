class SearchModel{
  bool? status ;
  String? message ;
  Data? data ;
  SearchModel.fromJson(Map<String,dynamic>json){
    status= json["status"] ;
    message= json["message"] ;
    data = Data.fromJson(json['data']) ;
  }
}
class Data{
  int? currentPage ;
  List<DataProduct>? dataProduct = [] ;
  Data.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element){
      dataProduct!.add( DataProduct.fromJson(element)) ;
    });
  }
}

class DataProduct{
  int? id ;
  var price ;
  String? image ;
  String? name ;
  String? description ;
  bool? inFavorites ;
  DataProduct.fromJson(Map<String,dynamic>json){
    id = json["id"] ;
    price = json["price"] ;
    image = json["image"] ;
    name = json["name"] ;
    description = json["description"] ;
    inFavorites = json["in_favorites"] ;
  }
}