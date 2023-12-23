import 'package:exe201_lumos_mobile/component/button_Widget.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/core/helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_intro/flutter_carousel_intro.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  static String routeName = '/intro_screen';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.white,
      child: IndexedStack(
        index: currentPage,
        children: [
          // Slide 1
          ImageHelper.loadFormAsset(AssetHelper.imgIntro1, fit: BoxFit.cover),
          // Slide 2
          ImageHelper.loadFormAsset(AssetHelper.imgIntro2, fit: BoxFit.cover),
          // Slide 3
          ImageHelper.loadFormAsset(AssetHelper.imgIntro3, fit: BoxFit.cover),
          // Slide 4
          ImageHelper.loadFormAsset(AssetHelper.imgIntro4, fit: BoxFit.cover),
          // Get Started Button
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(60.0),
              child: ButtonWidget(
                title: 'Get Started',
                ontap: () {
                  Navigator.of(context).pushNamed('/your_route_name');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
