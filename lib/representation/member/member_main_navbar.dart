import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:exe201_lumos_mobile/representation/member/member_booking.dart';
import 'package:exe201_lumos_mobile/representation/member/member_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

import '../../core/const/color_const.dart';
import '../../core/const/lumos_icons.dart';
import '../share/account_screen.dart';
import 'home_screen.dart';

class MemberMain extends StatefulWidget {
  const MemberMain({super.key});

  static String routName = '/member_main';

  @override
  State<MemberMain> createState() => _MemberMainState();
}

class _MemberMainState extends State<MemberMain> {
  dynamic selected;
  var heart = false;
  PageController controller = PageController();

  var _selectedTab = _SelectedTab.Home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: IndexedStack(
        index: _selectedTab.index,
        children: const [
          MemberHome(),
          MemberBooking(),
          MemberNotification(),
          AccountScreen(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: DotNavigationBar(
          backgroundColor: const Color.fromARGB(182, 164, 144, 124),
          margin: const EdgeInsets.only(left: 5, right: 5),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          dotIndicatorColor: ColorPalette.pink,
          unselectedItemColor: ColorPalette.white,
          splashBorderRadius: 20,
          enableFloatingNavBar: true,
          borderRadius: 20,
          enablePaddingAnimation: false,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(LumosIcons.home_1icon),
              selectedColor: ColorPalette.selectedPink,
            ),

            /// Request
            DotNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.notesMedical),
              selectedColor: ColorPalette.selectedPink,
            ),

            /// Message
            DotNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.solidBell),
              selectedColor: ColorPalette.selectedPink,
            ),

            /// Account
            DotNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.solidUser),
              selectedColor: ColorPalette.selectedPink,
            ),
          ],
        ),
      ),
    );
  }
}

enum _SelectedTab { Home, Booking, Notification, Account }
