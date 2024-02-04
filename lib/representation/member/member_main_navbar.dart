import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:exe201_lumos_mobile/representation/member/member_coming_booking.dart';
import 'package:exe201_lumos_mobile/representation/member/member_home.dart';
import 'package:exe201_lumos_mobile/representation/share/notification_screen.dart';
import 'package:flutter/material.dart';

import '../../core/const/color_const.dart';
import '../../core/const/lumos_icons.dart';
import '../share/account_screen.dart';

class MemberMain extends StatefulWidget {
  const MemberMain({super.key});

  static String routeName = '/member_main';

  @override
  State<MemberMain> createState() => _MemberMainState();
}

class _MemberMainState extends State<MemberMain> {
  var _selectedTab = _SelectedTab.Home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: IndexedStack(
        index: _selectedTab.index,
        children: const [
          MemberHome(),
          MemberComingBooking(),
          NotificationScreen(),
          AccountScreen(),
        ],
      ),
      extendBody: true,
      extendBodyBehindAppBar: false,
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: ColorPalette.pink,
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTap: _handleIndexChanged,
        dotIndicatorColor: ColorPalette.pink,
        unselectedItemColor: ColorPalette.white,
        splashBorderRadius: 50,
        enableFloatingNavBar: true,
        enablePaddingAnimation: false,
        splashColor: Colors.transparent,
        //disable splash
        marginR: const EdgeInsets.symmetric(horizontal: 40),
        paddingR: const EdgeInsets.symmetric(vertical: 3),
        items: [
          /// Home
          DotNavigationBarItem(
            icon: const Icon(
              LumosIcons.home_1icon,
              size: 30,
            ),
            selectedColor: ColorPalette.selectedPink,
          ),

          /// booking
          DotNavigationBarItem(
            icon: const Icon(
              Icons.calendar_month_outlined,
              size: 30,
            ),
            selectedColor: ColorPalette.selectedPink,
          ),

          /// notification
          DotNavigationBarItem(
            icon: const Icon(
              LumosIcons.bellicon,
              size: 30,
            ),
            selectedColor: ColorPalette.selectedPink,
          ),

          /// Account
          DotNavigationBarItem(
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
            selectedColor: ColorPalette.selectedPink,
          ),
        ],
      ),
    );
  }
}

enum _SelectedTab { Home, Booking, Notification, Account }
