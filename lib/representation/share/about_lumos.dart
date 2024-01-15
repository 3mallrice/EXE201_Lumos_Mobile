import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/const/zalo_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorPalette.bluelight,
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                Container(
                  height: 70,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  decoration: const BoxDecoration(
                    color: ColorPalette.bluelight,
                    border: Border(
                      bottom: BorderSide(
                        color: ColorPalette.secondaryWhite,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trở thành partner',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: ColorPalette.blueBold2,
                            fontSize: 16,
                            // fontFamily: 'verdana',
                            fontWeight: FontWeight.normal,
                            height: 0.08,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: ColorPalette.bluelight,
                    border: Border(
                      bottom: BorderSide(
                        color: ColorPalette.secondaryWhite,
                        width: 2,
                      ),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Licence & Policy',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: ColorPalette.blueBold2,
                            fontSize: 16,
                            // fontFamily: 'verdana',
                            fontWeight: FontWeight.w400,
                            height: 0.08,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: ColorPalette.bluelight,
                    border: Border(
                      bottom: BorderSide(
                        color: ColorPalette.secondaryWhite,
                        width: 2,
                      ),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lumos.com.vn',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: ColorPalette.blueBold2,
                            fontSize: 16,
                            fontFamily: 'verdana',
                            fontWeight: FontWeight.w700,
                            height: 0.08,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: ColorPalette.bluelight,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Liên hệ với',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: ColorPalette.blueBold2,
                                fontSize: 16,
                                // fontFamily: 'verdana',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                          Text(
                            ' Lumos',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: ColorPalette.blueBold2,
                                fontSize: 16,
                                // fontFamily: 'verdana',
                                fontWeight: FontWeight.w700,
                                height: 0.08,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 52,
                              width: 52,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: const ShapeDecoration(
                                color: ColorPalette.blueBold2,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed(UpdateAccount.routeName);
                                },
                                icon: const Icon(
                                  EvaIcons.facebook,
                                  size: 35,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 52,
                              width: 52,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: const ShapeDecoration(
                                color: ColorPalette.blueBold2,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                padding: const EdgeInsets.only(bottom: 3),
                                onPressed: () {
                                  // Navigator.of(context).pushNamed(UpdateAccount.routeName);
                                },
                                icon: const Icon(
                                  Ionicons.logo_youtube,
                                  size: 35,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 52,
                              width: 52,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: const ShapeDecoration(
                                color: ColorPalette.blueBold2,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                padding: const EdgeInsets.only(bottom: 2),
                                onPressed: () {
                                  // Navigator.of(context).pushNamed(UpdateAccount.routeName);
                                },
                                icon: const Icon(
                                  Ionicons.logo_tiktok,
                                  size: 30,
                                  fill: 1,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              height: 52,
                              width: 52,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: const ShapeDecoration(
                                color: ColorPalette.blueBold2,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed(UpdateAccount.routeName);
                                },
                                icon: const Icon(
                                  ZaloIcon.group_1000004349,
                                  size: 30,
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
