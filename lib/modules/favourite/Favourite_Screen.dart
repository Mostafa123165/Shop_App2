import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/lay_out/Cubit/States.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener:(context,state){} ,
      builder: (context,state){
        return ConditionalBuilder(
            condition: state is! GetsDateFavouriteLoadingState ,
            builder: (context) => ListView.separated(
              itemBuilder: (context,index) => favouriteItems(ShopCubit.get(context).favouriteModel!.dataFavourite!.dataProduct![index].product!,context),
              separatorBuilder: (context,state) => const SizedBox(height: 10,) ,
              itemCount:ShopCubit.get(context).favouriteModel!.dataFavourite!.dataProduct!.length ,
            ) ,
            fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
        );
      }
    );
  }
  Widget favouriteItems(model, context) =>  Row(
    children: [
      CachedNetworkImage(
        imageUrl: '${model.image}',
        placeholder:(context,state)=> const Center(child: CircularProgressIndicator()),
        height: 100,
        width: 100,
      ),
        const SizedBox(width: 7,),
        Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
  children: [
            Text(
              '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13.0,
                  height: 1.3,
                ),
            ),
           const SizedBox(height: 20.0,),
            Row(
              children: [
                Text(
                  '${model.price}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 13.0,
                    height: 1.3,
                  ),
                ),
                const Spacer() ,
                IconButton(onPressed: (){
                  ShopCubit.get(context).changeFavourite(model.id) ;
                },
                  icon:const CircleAvatar(
                  radius: 15.0,
                  child:  Icon(
                    size: 17.0,
                    Icons.favorite_border_rounded,
                    color: Colors.white,
                  ),
                ), ),
              ],
            )
          ],
        ),
      )
    ],
  );
}