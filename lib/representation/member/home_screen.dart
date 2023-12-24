import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/material.dart';

class MemberHome extends StatefulWidget {
  const MemberHome({super.key});

  static String routeName = '/member_home';

  @override
  State<MemberHome> createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width; //set width = screenWidth
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: screenWidth,
            height: 56,
            color: ColorPalette.blue,
          ),
        ],
      ),
    );
  }
}
