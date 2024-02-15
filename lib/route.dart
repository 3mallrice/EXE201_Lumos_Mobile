import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/intro_screen.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report_addnew.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report_detail.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report_update.dart';
import 'package:exe201_lumos_mobile/representation/member/member_address.dart';
import 'package:exe201_lumos_mobile/representation/member/member_bill_detail.dart';
import 'package:exe201_lumos_mobile/representation/member/member_coming_booking.dart';
import 'package:exe201_lumos_mobile/representation/member/member_home.dart';
import 'package:exe201_lumos_mobile/representation/member/member_main_navbar.dart';
import 'package:exe201_lumos_mobile/representation/member/partner_service_list.dart';
import 'package:exe201_lumos_mobile/representation/member/payment_method.dart';
import 'package:exe201_lumos_mobile/representation/member/search_booking.dart';
import 'package:exe201_lumos_mobile/representation/share/about_lumos.dart';
import 'package:exe201_lumos_mobile/representation/share/account_screen.dart';
import 'package:exe201_lumos_mobile/representation/share/account_update.dart';
import 'package:exe201_lumos_mobile/representation/share/bill_screen.dart';
import 'package:exe201_lumos_mobile/representation/share/notification_screen.dart';
import 'package:exe201_lumos_mobile/representation/splash_screen.dart';
import 'package:exe201_lumos_mobile/sign_up.dart';
import 'package:flutter/material.dart';

import 'representation/member/member_booking.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  Login.routeName: (context) => const Login(),
  SignUp.routeName: (context) => const SignUp(),
  AccountScreen.routeName: (context) => const AccountScreen(),
  UpdateAccount.routeName: (context) => const UpdateAccount(),
  BillScreen.routeName: (context) => const BillScreen(),
  AboutUs.routeName: (context) => const AboutUs(),
  MemberMain.routeName: (context) => const MemberMain(),
  MemberHome.routeName: (context) => const MemberHome(),
  PaymentMethod.routeName: (context) => const PaymentMethod(),
  MemberComingBooking.routeName: (context) => const MemberComingBooking(),
  MedicalReport.routeName: (context) => const MedicalReport(),
  MedicalReportDetail.routeName: (context) => const MedicalReportDetail(),
  MedicalReportUpdate.routeName: (context) => const MedicalReportUpdate(),
  MedicalReportAdd.routeName: (context) => const MedicalReportAdd(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  MemberAddress.routeName: (context) => const MemberAddress(),
  SearchBooking.routeName: (context) => const SearchBooking(),
  BillDetail.routeName: (context) => const BillDetail(),
  PartnerServiceList.routeName: (context) => const PartnerServiceList(),
  BookingPage.routeName: (context) => const BookingPage(),
};
