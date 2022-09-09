import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/lay_out/Cubit/States.dart';
import 'package:shopapp2/model/Categories_model.dart';
import 'package:shopapp2/model/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ShopCubit,ShopState>(

      listener: (context,state) {},
      builder: (context,state) =>ConditionalBuilder(
         condition:ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categoriesMode!=null,
         builder:(context) => BuildItem(model: ShopCubit.get(context).homeModel,context:context),
         fallback: (context)=>const Center(child: CircularProgressIndicator()),

      ),
    );
  }

  Widget BuildItem({HomeModel? model ,  context})=> SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model!.data!.banners!.map((e) =>
                CachedNetworkImage(
                  imageUrl:  "${e.image}",
                  placeholder:(context,state)=> const Center(child: CircularProgressIndicator()),
                   fit: BoxFit.cover,
                ),).toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
            )
        ),
        const SizedBox(
          height:10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 25.0),
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>buildItemsCategories(ShopCubit.get(context).categoriesMode,index),
                  separatorBuilder:(context,state)=> const SizedBox(width: 10.0,),
                  itemCount:ShopCubit.get(context).categoriesMode!.dateCategories!.dateProduct!.length,
                ),
              ),
              const SizedBox(
                height:10.0,
              ),
              const Text(
                'Products',
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 1.735,
          mainAxisSpacing: 1.0,
          children: List.generate(ShopCubit.get(context).homeModel!.data!.products!.length, (index) =>buildItemsProducts(ShopCubit.get(context).homeModel!.data!.products![index] , context , index) ),
        ),

      ],
    ),
  );

  Widget buildItemsProducts( ProductModel model , context , int index) =>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200.0,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                imageUrl: '${model.image}',
                placeholder:(context,state)=> const Center(child: CircularProgressIndicator()),
                height: 200.0,
                width: double.infinity,
              ),
              if(model.discount != 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Container(
                  color: Colors.red,
                  child: const Text(
                    'discount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          height: 33.0,
          child: Text(
            '${model.name}',
            style: const TextStyle(
              fontSize:13.0,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          children: [
            Text(
                '${model.price}',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14.0
              ),
            ),
            const SizedBox(width: 5,),
            if(model.discount != 0)
            Text(
              '${model.oldPrice}',
              style: const TextStyle(
                  color: Colors.grey,
                 decoration: TextDecoration.lineThrough,
                  fontSize: 11.0
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: (){
                ShopCubit.get(context).changeFavourite(model.id??0) ;
              },
              icon:CircleAvatar(
              radius: 15.0,
            //  backgroundColor:model.inFavorites! ? Colors.blue : Colors.grey[400] ,
                backgroundColor: ShopCubit.get(context).favorites[model.id] == false ? Colors.grey[400] : Colors.blue,
                child:  Icon(
                size: 17.0,
                Icons.favorite_border_rounded,
                color: Colors.white,
              ),
            ), )

          ],
        ),
      ],
    ),
  );

  Widget buildItemsCategories(CategoriesModel? model ,int index) => Stack(
    alignment: Alignment.bottomRight,
    children: [
      CachedNetworkImage(
        imageUrl: '${model!.dateCategories!.dateProduct![index].image}',
        placeholder:(context,state)=> const Center(child: CircularProgressIndicator()),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),

      Container(
        color: Colors.black.withOpacity(.7),
        width: 100,
        child: Text(
          '${model.dateCategories!.dateProduct![index].name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize:15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
