import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/lay_out/Cubit/States.dart';
import 'package:shopapp2/shared/network/local/cash_helper.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar:AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50 ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Automatic Dark Mode',
                        style: TextStyle(
                            fontSize: 17
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Text(
                            'Use System light/dark mode setting',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                          const Spacer(),
                          FlutterSwitch(
                              width: 40,
                              toggleSize: 15.0,
                              height:20 ,
                              padding: 2.0,
                              toggleColor: Color.fromRGBO(225, 225, 225, 1),
                              inactiveColor: Colors.black38,
                              value: CashHelper.getDate(key: 'dark'), // possible null value in start programme
                              onToggle: (value){
                                  ShopCubit.get(context).changeAppMode() ;
                              }
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Automatic Language',
                        style: TextStyle(
                            fontSize: 17
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Text(
                            'Use System English/Arabic ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                          const Spacer(),
                          FlutterSwitch(
                              width: 40,
                              toggleSize: 15.0,
                              height:20 ,
                              padding: 2.0,
                              toggleColor: Color.fromRGBO(225, 225, 225, 1),
                              inactiveColor: Colors.black38,
                              value: ShopCubit.get(context).isEnglish,
                              onToggle: (value){
                                ShopCubit.get(context).changeLangSwitch(value) ;
                                print('${ShopCubit.get(context).isEnglish}') ;
                              }

                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

