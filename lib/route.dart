import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/intro_screen.dart';
import 'package:exe201_lumos_mobile/representation/member/member_booking.dart';
import 'package:exe201_lumos_mobile/representation/member/member_home.dart';
import 'package:exe201_lumos_mobile/representation/member/member_main_navbar.dart';
import 'package:exe201_lumos_mobile/representation/member/payment_method.dart';
import 'package:exe201_lumos_mobile/representation/share/about_lumos.dart';
import 'package:exe201_lumos_mobile/representation/share/account_screen.dart';
import 'package:exe201_lumos_mobile/representation/share/account_update.dart';
import 'package:exe201_lumos_mobile/representation/share/bill_screen.dart';
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
  BillScreen.routeName: (context) => const BillScreen(),
  AboutUs.routeName: (context) => const AboutUs(),

  //Member
  MemberMain.routName: (context) => const MemberMain(),
  MemberHome.routeName: (context) => const MemberHome(),
  PaymentMethod.routeName: (context) => const PaymentMethod(),
  MemberBooking.routeName: (context) => const MemberBooking(),

  //Nurse
};
