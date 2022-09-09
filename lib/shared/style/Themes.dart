import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkThem() => ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: HexColor('2b2c2c'),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black12,
          statusBarIconBrightness: Brightness.light,
        ),
        titleSpacing: 20.0,
        backgroundColor: Colors.black12,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        elevation: 0.0,
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: Colors.white,
        ), // textFormFeild
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 20.0,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black12,
        unselectedItemColor: Colors.grey,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        iconColor: Colors.white,
        fillColor: Colors.black26,
        filled: true,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: HexColor('2b2c2c'),
      ),
    );

ThemeData lightThem() => ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        titleSpacing: 20.0,
        color: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.dark,
        ),
        actionsIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        elevation: 0.0,
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(
          color: Colors.black,
        ), // textFormFeild
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 20.0,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.white54,
        unselectedItemColor: Colors.black45,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        iconColor: Colors.black,
        fillColor: Colors.white,
        filled: true,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
    );
