import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/model/home_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).categoriesMode ;
    return ListView.separated(
        itemBuilder: (context,index) => buildCategoriesItems(model , index) ,
        separatorBuilder: (context , stat) => const Divider(
            height: 7,
            thickness: 1,
            endIndent: 0,

        ),
        itemCount: model!.dateCategories!.dateProduct!.length);
  }
  Widget buildCategoriesItems (model , int index) => Row(
    children: [
      CachedNetworkImage(
        imageUrl: '${model!.dateCategories!.dateProduct![index].image}',
        placeholder:(context,state)=> const Center(child: CircularProgressIndicator()),
        width: 100,
        height: 100,
      ),
      const SizedBox(width: 10.0,),
      Text(
          '${model.dateCategories!.dateProduct![index].name}'
      ),
      const Spacer() ,
      IconButton(
          onPressed: (){}, icon: Icon(
        Icons.arrow_forward_ios,
        color: Colors.blue,
      )
      ),
    ],
  );
}