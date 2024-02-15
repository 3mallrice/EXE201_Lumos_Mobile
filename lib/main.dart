import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/representation/splash_screen.dart';
import 'package:exe201_lumos_mobile/route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      //initiation locale for my material app
      locale: const Locale('vi', 'VN'),
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Lumos - Health and Trust',
      theme: ThemeData(
        fontFamily: GoogleFonts.almarai().fontFamily,
        useMaterial3: true,
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
