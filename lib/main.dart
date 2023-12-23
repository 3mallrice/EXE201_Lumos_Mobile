import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/representation/splash_screen.dart';
import 'package:exe201_lumos_mobile/route.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumos - Health and Trust',
      theme: ThemeData(
        primaryColor: ColorPalette.white,
        scaffoldBackgroundColor: ColorPalette.white,
      ),
      debugShowCheckedModeBanner: false,
      //home: const HomePage(),
      home: const SplashScreen(),
      // home: LoginPage(),
      routes: routes,
    );
  }
}

