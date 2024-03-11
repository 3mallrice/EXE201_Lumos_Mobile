import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/const/front-end/color_const.dart';
import 'core/helper/local_storage_helper.dart';
import 'representation/splash_screen.dart';
import 'route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initiate hive
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

      onGenerateTitle: (BuildContext context) {
        return "Lumos - Mothers' Home Healthcare";
      },

      //Restoration State
      restorationScopeId: "Lumos",

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: ThemeMode.dark,
      title: 'Lumos - Mothers\' Home Healthcare',
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
        primaryColor: ColorPalette.white,
        scaffoldBackgroundColor: ColorPalette.white,
        dialogTheme: const DialogTheme(
          contentTextStyle: TextStyle(
            color: ColorPalette.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.clip,
          ),
          backgroundColor: ColorPalette.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          titleTextStyle: TextStyle(
            color: ColorPalette.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconColor: ColorPalette.pinkBold,
          actionsPadding: EdgeInsets.only(right: 10, bottom: 10),
          elevation: 4,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const AspectRatio(
        aspectRatio: 1,
        child: SplashScreen(),
      ),
      routes: routes,
    );
  }
}
