import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  static String routeName = '/about_lumos';

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Về chúng tôi',
        leading: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: const BoxDecoration(
              color: ColorPalette.bluelight,
              border: Border(
                bottom: BorderSide(
                  color: ColorPalette.secondaryWhite,
                  width: 2,
                ),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trở thành partner',
                  style: TextStyle(
                    color: ColorPalette.blueBold2,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                    letterSpacing: 0.10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: ColorPalette.bluelight,
              border: Border(
                bottom: BorderSide(
                  color: ColorPalette.secondaryWhite,
                  width: 2,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Licence & Policy',
                  style: TextStyle(
                    color: ColorPalette.blueBold2,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                    letterSpacing: 0.10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: ColorPalette.bluelight,
              border: Border(
                bottom: BorderSide(
                  color: ColorPalette.secondaryWhite,
                  width: 2,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lumos.com.vn',
                  style: TextStyle(
                    color: ColorPalette.blueBold2,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0.08,
                    letterSpacing: 0.10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
