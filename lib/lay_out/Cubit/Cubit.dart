
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Cubit/States.dart';
import 'package:shopapp2/model/Categories_model.dart';
import 'package:shopapp2/model/favourite_model.dart';
import 'package:shopapp2/model/home_model.dart';
import 'package:shopapp2/model/search_model.dart';
import 'package:shopapp2/modules/category/Category_Screen.dart';
import 'package:shopapp2/modules/favourite/Favourite_Screen.dart';
import 'package:shopapp2/modules/products/Products_screen.dart';
import 'package:shopapp2/modules/profile/Profile_Screen.dart';
import 'package:shopapp2/shared/components/constant.dart';
import 'package:shopapp2/shared/network/CashHelper2.dart';
import 'package:shopapp2/shared/network/end_points.dart';
import 'package:shopapp2/shared/network/local/cash_helper.dart';
import 'package:shopapp2/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState>{
 ShopCubit() : super(ShopInitialState()) ;
 int currentIndexNav = 0 ;
 static ShopCubit get(context) => BlocProvider.of(context) ;
 List<Widget>screen=[
  const ProductsScreen() ,
  const CategoryScreen() ,
  const FavouriteScreen() ,
  const ProfileScreen() ,
 ];

 List<BottomNavigationBarItem>itemsBottomNav=[
  const BottomNavigationBarItem(
   icon: Icon(Icons.home_outlined),
   label: 'Home',

  ),
  const BottomNavigationBarItem(
   icon: Icon(Icons.apps),
   label: 'Categories',

  ),
  const BottomNavigationBarItem(
   icon: Icon(Icons.favorite_outline),
   label: 'Favourite',

  ),
  const BottomNavigationBarItem(
   icon: Icon(Icons.person_rounded),
   label: 'Profile',
  ),
 ];


 bool isEnglish = true ;
 bool isDark = false ;

 void changeAppMode({bool? formShared}){
  emit(ChangeSwitchModeLoadingState()) ;
    if(formShared == null){
     isDark = !isDark ;
    }else {
     isDark = formShared ;
    }
    CashHelper.saveData(
        key: "dark",
        val: isDark
    ).then((value) => {
        emit(ChangeSwitchModeSuccessState()) ,
    }).catchError((error){
     emit(ChangeSwitchModeErrorState());
     print(error.toString());
    });

 }



 void changeLangSwitch(bool english){
  isEnglish = english ;
  emit(ChangeSwitchLangState()) ;
 }

 Map<int , bool >favorites  = {} ;

 void changeBottomNav(int index){
  currentIndexNav = index ;
  emit(ChangeBottomNavState()) ;
 }
 HomeModel? homeModel ;
 void getHomeDate(){
  emit(GetDateHomeLoadingState());
  DioHelper.getDate(
      url: HOME,
      token: token??"",
  ).then((value) =>{
   homeModel = HomeModel.formJson(value.data) ,
   homeModel!.data!.products!.forEach((element) {
    favorites.addAll({
      element.id! : element.inFavorites! ,
    });
   }),
   printFullText(homeModel.toString()),
    emit(GetDateHomeSuccessState()),

  }).catchError((error){
   print(error.toString());
   emit(GetDateHomeErrorState());
  });
 }

 CategoriesModel? categoriesMode ;
 void getDateCategories(){
  emit(GetsDateCategoriesLoadingState());
  DioHelper.getDate(
   url: CATEGORIES,
  ).then((value) =>{
   categoriesMode = CategoriesModel.fromJson(value.data) ,
   printFullText(categoriesMode.toString()),
   emit(GetsDateCategoriesSuccessState()),

  }).catchError((error){
   print(error.toString());
   emit(GetsDateCategoriesErrorState());
  });
 }

 FavouriteModel? favouriteModel ;
 void getDateFavourite(){
  emit(GetsDateFavouriteLoadingState());
  DioHelper.getDate(
   url: FAVORITES,
   token: token??'' ,
  ).then((value) =>{
   favouriteModel = FavouriteModel.fromJson(value.data!),
   //print(favouriteModel!.dataFavourite!.dataProduct![0].product!.image),
   emit(GetsDateFavouriteSuccessState()),

  }).catchError((error){
   print(error.toString());
   emit(GetsDateFavouriteErrorState());
  });
 }

 void changeFavourite( int product){
  favorites[product] = !favorites[product]!;
  emit(ChangeDateFavouriteLoadingState()) ;
  DioHelper.posDate(
      url:FAVORITES,
      token: token,
      data: {
       "product_id" : product ,
      },
  ).then((value) =>{

   getDateFavourite(),

   emit(ChangeDateFavouriteSuccessState()),
  }).catchError((error){
   print(error.toString());
   emit(ChangeDateFavouriteErrorState());
  });
 }


 SearchModel? searchModel ;
 void searchProduct(String? text){
  emit(SearchLoadingState());
  DioHelper.posDate(
   url: SEARCH,
   data: {
    "text":text,
   },
   token: token??'' ,
  ).then((value) =>{
   searchModel = SearchModel.fromJson(value.data!),
   print(searchModel.toString()),
   emit(SearchSuccessState()),
  }).catchError((error){
   print(error.toString());
   emit(SearchErrorState());
  });
 }


}