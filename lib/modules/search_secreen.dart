import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/lay_out/Cubit/States.dart';
import 'package:shopapp2/model/search_model.dart';
import 'package:shopapp2/shared/components/components.dart';

class Search_screen extends StatelessWidget {
  const Search_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputUser = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (_) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    defaultTextFormFeild(
                        controller: inputUser,
                        submitted: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context)
                                .searchProduct(inputUser.text);
                          }
                        },
                        validator: (value) {
                          if (value.toString().isEmpty || value == null) {
                            return "PLease Enter name product";
                          }
                          return null;
                        },
                        lapel: 'Search'),
                    const SizedBox(
                      height: 5,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (ShopCubit.get(context).searchModel != null)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => builds(
                              ShopCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .dataProduct![index],
                              context),
                          separatorBuilder: (context, state) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: ShopCubit.get(context)
                              .searchModel!
                              .data!
                              .dataProduct!
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget builds(DataProduct? model, context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: '${model!.image}',
                    placeholder: (context, state) =>
                        const Center(child: CircularProgressIndicator()),
                    height: 200.0,
                    width: 100,
                  ),
                  //  if(model.discount != 0)
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
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${model.price}\$',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavourite(model.id ?? 0);
                            },
                            icon: const CircleAvatar(
                              radius: 15.0,
                              child: Icon(
                                size: 17.0,
                                Icons.favorite_border_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
