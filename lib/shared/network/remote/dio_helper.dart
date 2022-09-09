

import 'package:dio/dio.dart';
 class DioHelper{
  static Dio? dio ;
  static init(){
     dio =  Dio(
       BaseOptions(
         baseUrl: 'https://student.valuxapps.com/api/' ,
         receiveDataWhenStatusError: true ,
       ),
     );
   }

  static Future<Response> getDate({
   required String url ,
   String? token  ,
   String? lang = "en" ,
   Map<String,dynamic>?query,
 })async{
    dio!.options.headers ={
      "Authorization" : token?? "",
      "Content-Type" : "application/json",
       "lang" : lang ,
    };
   return await dio!.get(
       url,
    );
   }

  static Future<Response> posDate({
    required String url ,
    required Map<String ,dynamic>? data ,
    String? token  ,
    Map<String,dynamic>?query,
  })async{
    dio!.options.headers ={
      "Authorization" : token?? "",
      "Content-Type" : "application/json",
    };
    return await dio!.post(
      url,
      data: data ,
    );
  }


 }
