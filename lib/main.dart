import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/representation/splash_screen.dart';
import 'package:exe201_lumos_mobile/route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/helper/local_storage_helper.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumos - Health and Trust',
      theme: ThemeData(
        primaryColor: ColorPalette.white,
        scaffoldBackgroundColor: ColorPalette.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const AspectRatio(
        aspectRatio: 16 / 9,
        child: SplashScreen(),
      ),
      routes: routes,
    );
  }
}
