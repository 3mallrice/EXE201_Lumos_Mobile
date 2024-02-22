import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/const/front-end/zalo_icon.dart';
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
      body: IntrinsicHeight(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorPalette.bluelight,
          ),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Trở thành partner',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: ColorPalette.blueBold2,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                const Divider(color: ColorPalette.white),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Licence & Policy',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: ColorPalette.blueBold2,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Divider(color: ColorPalette.white),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Lumos.com.vn',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: ColorPalette.blueBold2,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Divider(color: ColorPalette.white),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Liên hệ với',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: ColorPalette.blueBold2,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            ' Lumos',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: ColorPalette.blueBold2,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(14),
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
                                color: ColorPalette.white,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(14),
                            decoration: const ShapeDecoration(
                              color: ColorPalette.blueBold2,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Navigator.of(context).pushNamed(UpdateAccount.routeName);
                              },
                              icon: const Icon(
                                Ionicons.logo_youtube,
                                size: 35,
                                color: ColorPalette.white,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(14),
                            decoration: const ShapeDecoration(
                              color: ColorPalette.blueBold2,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Navigator.of(context).pushNamed(UpdateAccount.routeName);
                              },
                              icon: const Icon(
                                Ionicons.logo_tiktok,
                                size: 35,
                                color: ColorPalette.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(14),
                            alignment: Alignment.center,
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
                                size: 35,
                                color: ColorPalette.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
