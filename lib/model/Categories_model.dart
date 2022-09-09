class CategoriesModel {
  bool? status ;
  CategoriesDate? dateCategories ;


  CategoriesModel.fromJson(Map<String ,dynamic>json){
    status = json["status"] ;
    dateCategories =CategoriesDate.fromJson(json["data"])  ;
  }

}

class CategoriesDate{

int? currentPage ;
List<ProductDate>?dateProduct = [];

CategoriesDate.fromJson(Map<String ,dynamic>json){
  currentPage = json["current_page"];
   json["data"].forEach((elements){
     dateProduct!.add(ProductDate.fromJson(elements));
   });
}

}

class ProductDate{

int? id ;
String? name ;
String? image;

ProductDate.fromJson(Map<String ,dynamic>json){
  id = json["id"] ;
  name = json["name"] ;
  image = json["image"] ;
}

}

