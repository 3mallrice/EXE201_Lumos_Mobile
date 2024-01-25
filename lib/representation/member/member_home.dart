import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FractionallySizedBox(
          widthFactor: 0.3,
          child: Image.asset(
            AssetHelper.imglogo2,
            fit: BoxFit.fitWidth,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Align(
        alignment: AlignmentDirectional.topCenter,
        child: SingleChildScrollView(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: ShapeDecoration(
                color: ColorPalette.bluelight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 18),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: const ShapeDecoration(
                              color: ColorPalette.blue,
                              shape: OvalBorder(),
                            ),
                          ),
                          const Positioned(
                            child: Icon(
                              Icons.medical_services,
                              color: ColorPalette.blueBold2,
                              size: 31,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 18),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: const ShapeDecoration(
                              color: ColorPalette.blue,
                              shape: OvalBorder(),
                            ),
                          ),
                          const Positioned(
                            child: Icon(
                              Icons.medical_services,
                              color: ColorPalette.blueBold2,
                              size: 31,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 18),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: const ShapeDecoration(
                              color: ColorPalette.blue,
                              shape: OvalBorder(),
                            ),
                          ),
                          const Positioned(
                            child: Icon(
                              Icons.medical_services,
                              color: ColorPalette.blueBold2,
                              size: 31,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 18),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: const ShapeDecoration(
                              color: ColorPalette.blue,
                              shape: OvalBorder(),
                            ),
                          ),
                          const Positioned(
                            child: Icon(
                              Icons.medical_services,
                              color: ColorPalette.blueBold2,
                              size: 31,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
