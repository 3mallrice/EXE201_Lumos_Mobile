import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/core/helper/image_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // widget nào được viết trước sẽ nằm phía dưới còn widget nào viết sau sẽ nằm phía trên
      children: [
        Positioned.fill(
            child: ImageHelper.loadFormAsset(AssetHelper.imgSplashBg,
                fit: BoxFit.fitWidth)),
        Positioned.fill(child: ImageHelper.loadFormAsset(AssetHelper.imgLogo)),
      ],
    );
  }
}
