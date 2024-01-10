import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/intro_screen.dart';
import 'package:exe201_lumos_mobile/representation/member/home_screen.dart';
import 'package:exe201_lumos_mobile/representation/share/account_screen.dart';
import 'package:exe201_lumos_mobile/representation/share/account_update.dart';
import 'package:exe201_lumos_mobile/representation/splash_screen.dart';
import 'package:exe201_lumos_mobile/sign_up.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  Login.routeName: (context) => const Login(),
  SignUp.routeName: (context) => const SignUp(),

  //share
  AccountScreen.routeName: (context) => const AccountScreen(),
  UpdateAccount.routeName: (context) => const UpdateAccount(),

  //Member
  MemberHome.routeName: (context) => const MemberHome(),

  //Nurse
};
