import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp2/lay_out/Cubit/Cubit.dart';
import 'package:shopapp2/lay_out/Cubit/States.dart';
import 'package:shopapp2/lay_out/Shop_Layout.dart';
import 'package:shopapp2/modules/login/login_screnn.dart';
import 'package:shopapp2/modules/on_boarding_screen.dart';
import 'package:shopapp2/shared/block_opserver.dart';
import 'package:shopapp2/shared/components/constant.dart';
import 'package:shopapp2/shared/network/CashHelper2.dart';
import 'package:shopapp2/shared/network/local/cash_helper.dart';
import 'package:shopapp2/shared/network/remote/dio_helper.dart';
import 'package:shopapp2/shared/style/Themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  DioHelper.init();
  bool? onBoarding = CashHelper.getDate(key: "onBoarding");
  bool? loginScreen = CashHelper.getDate(key: "loginScreen");
  token = CashHelper.getDate(key: "token");
  bool? dark = CashHelper.getDate(key: "dark");
  bool? isLightMode = CashHelper.getDate(key: 'isLightMode');

  print('aaaaaaaaaaaaaaaa');
  print(dark);
  Widget widget;
  if (onBoarding == true) {
    if (loginScreen == true)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
    isDark: dark,
    modeApp: isLightMode,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  final bool? isDark;

  final bool? modeApp;

  MyApp({this.startWidget, this.isDark, this.modeApp});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..changeAppMode(formShared: isDark)
            ..getHomeDate()
            ..getDateCategories()
            ..getDateFavourite(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThem(),
            darkTheme: darkThem(),
            themeMode: cubit.isDark == true ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            //home:LoginScreen(),
          );
        },
      ),
    );
  }
}
