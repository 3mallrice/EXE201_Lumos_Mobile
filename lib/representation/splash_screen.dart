import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/core/helper/image_helper.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/intro_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with RestorationMixin {
  @override
  void initState() {
    super.initState();
    redirectIntro();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  void redirectTo(String redirectTo) {
    Navigator.restorablePushReplacementNamed(context, redirectTo);
    // Navigator.of(context).pushReplacementNamed(redirectTo);
  }

  void redirectIntro() async {
    //await LocalStorageHelper.initLocalStorageHelper(); // Mở Hive box
    final ignoreIntroScreen =
        await LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;
    await Future.delayed(const Duration(milliseconds: 2000));

    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      redirectTo(Login.routeName);
    } else {
      LocalStorageHelper.setValue('ignoreIntroScreen', true);
      redirectTo(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // widget nào được viết trước sẽ nằm phía dưới còn widget nào viết sau sẽ nằm phía trên
      children: [
        Positioned.fill(
            child: ImageHelper.loadFormAsset(AssetHelper.imgSplashBg,
                fit: BoxFit.fitWidth)),
        Positioned.fill(child: ImageHelper.loadFormAsset(AssetHelper.imglogo1)),
      ],
    );
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => SplashScreen.routeName;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
  }
}
