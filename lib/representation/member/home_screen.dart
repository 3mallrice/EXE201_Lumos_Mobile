import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/core/helper/image_helper.dart';
import 'package:flutter/material.dart';

class MemberHome extends StatefulWidget {
  const MemberHome({Key? key}) : super(key: key);

  static String routeName = '/member_home';

  @override
  State<MemberHome> createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: const AppBarCom(
          appBarText: 'Trang chủ',
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              width: screenWidth,
              child: ImageHelper.loadFormAsset(AssetHelper.memberBanner,
                  fit: BoxFit.fill),
            ),
            const Positioned(
                top: 50.0,
                left: 30.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Y tế tại nhà',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    Text(
                      'Đặt lịch',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
