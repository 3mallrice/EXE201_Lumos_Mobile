import 'login.dart';
import 'representation/intro_screen.dart';
import 'representation/member/medical_report.dart';
import 'representation/member/medical_report_addnew.dart';
import 'representation/member/medical_report_detail.dart';
import 'representation/member/medical_report_update.dart';
import 'representation/member/member_address.dart';
import 'representation/member/member_address_add.dart';
import 'representation/member/member_bill_detail.dart';
import 'representation/member/member_coming_booking.dart';
import 'representation/member/member_home.dart';
import 'representation/member/member_main_navbar.dart';
import 'representation/member/partner_service_list.dart';
import 'representation/member/payment_method.dart';
import 'representation/member/search_booking.dart';
import 'representation/share/about_lumos.dart';
import 'representation/share/account_screen.dart';
import 'representation/share/account_update.dart';
import 'representation/share/bill_screen.dart';
import 'representation/share/notification_screen.dart';
import 'representation/splash_screen.dart';
import 'sign_up.dart';
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
  MedicalReportPage.routeName: (context) => const MedicalReportPage(),
  MedicalReportDetail.routeName: (context) => const MedicalReportDetail(),
  MedicalReportUpdate.routeName: (context) => const MedicalReportUpdate(),
  MedicalReportAdd.routeName: (context) => const MedicalReportAdd(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  MemberAddress.routeName: (context) => const MemberAddress(),
  SearchBooking.routeName: (context) => const SearchBooking(),
  BillDetail.routeName: (context) => const BillDetail(),
  PartnerServiceList.routeName: (context) => const PartnerServiceList(),
  BookingPage.routeName: (context) => const BookingPage(),
  AddressAdd.routeName: (context) => const AddressAdd(),
  AddressAdd.routeName: (context) => const AddressAdd(),
};
