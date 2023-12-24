import 'package:exe201_lumos_mobile/component/button_widget.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/core/helper/image_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/member/home_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static String routeName = '/intro_screen';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool isLastSlide = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.toInt() ?? 0;
        isLastSlide = currentPage == 3; // Cập nhật trạng thái cuối cùng
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //stack dùng để khi muốn các ảnh chồng lên nhau
        children: [
          // Slides
          PageView(
            controller: _pageController,
            children: [
              _buildSlide([AssetHelper.imgIntro1, AssetHelper.imgBgIntro1]),
              _buildSlide([AssetHelper.imgIntro2, AssetHelper.imgBgIntro2]),
              _buildSlide([AssetHelper.imgIntro3, AssetHelper.imgBgIntro3]),
              _buildSlide([AssetHelper.imgIntro4, AssetHelper.imgBgIntro4]),
            ],
          ),

          // Get Started Button
          Visibility(
            visible: isLastSlide,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(60.0),
                child: ButtonWidget(
                  title: 'Get Started',
                  ontap: () {
                    Navigator.of(context).pushNamed(Login.routeName);
                    //Navigator.of(context).pushNamed(MemberHome.routeName);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(List<String> assets) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageHelper.loadFormAsset(
            assets[1],
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned.fill(
          child: ImageHelper.loadFormAsset(assets[0]),
        ),
      ],
    );
  }
}
