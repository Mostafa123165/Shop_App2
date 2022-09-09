import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/lay_out/Cubit/States.dart';
import 'package:shopapp2/modules/login/login_screnn.dart';
import 'package:shopapp2/modules/search_secreen.dart';
import 'package:shopapp2/modules/setting/Setting_Screen.dart';
import 'package:shopapp2/shared/components/components.dart';
import 'package:shopapp2/shared/components/constant.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopState>(
      listener:(context,state) {},
      builder: (context,state){
        var cubit = ShopCubit.get(context) ;
        return Scaffold(
          drawer:Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  padding:const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                    child: Column(
                      children:  [
                         const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          backgroundImage: AssetImage(
                           'assets/image/first_onBoarding.png',
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          userName.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                      ],
                    ),
                ),
                ListTile(
                  leading:const Icon(Icons.home_outlined),
                  title: const Text(
                    'Home',

                  ),
                  onTap: (){
                    Navigator.pop(context);
                    ShopCubit.get(context).changeBottomNav(0);
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.person_rounded),
                  title: const Text(
                    'profile'
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    ShopCubit.get(context).changeBottomNav(3);
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.favorite),
                  title: const Text(
                    'Favourite',
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    ShopCubit.get(context).changeBottomNav(2);
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.settings),
                  title: const Text(
                    'Settings'
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> const SettingScreen()));
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.login_outlined),
                  title: const Text(
                    'Log Out'
                  ),
                  onTap: (){
                    navigateAndFinish(
                      context,
                      LoginScreen(),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text(
              'Home' ,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  print('isdark');
                  print(ShopCubit.get(context).isDark) ;
                  cubit.changeAppMode();
                  print('isdark');
                  print(ShopCubit.get(context).isDark) ;
                },
                icon: Icon(
                  Icons.dark_mode,
                ),
              ),
              IconButton(

                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Search_screen()));
                },
                icon: const Icon(Icons.search),
              ),

            ],
          ),
          body: cubit.screen[cubit.currentIndexNav],
          bottomNavigationBar:BottomNavigationBar(
            items: cubit.itemsBottomNav ,
            type: BottomNavigationBarType.fixed,
            onTap: (int index){
              cubit.changeBottomNav(index) ;
            },
            currentIndex: cubit.currentIndexNav,
          )
        );
      },

    );
  }
}
