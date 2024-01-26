import 'package:exe201_lumos_mobile/component/my_button.dart';
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
        alignment: AlignmentDirectional.center,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // mom
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //
                      },
                      icon: const Icon(
                        Icons.pregnant_woman,
                        color: ColorPalette.blueBold2,
                        size: 42,
                      ),
                      label: const Text(
                        'Mẹ bầu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorPalette.pinkBold,
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          height: 0.06,
                          letterSpacing: 0.10,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorPalette.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // son
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //
                      },
                      icon: const Icon(
                        Icons.child_friendly,
                        size: 42,
                        color: ColorPalette.blueBold2,
                      ),
                      label: const Text(
                        'Em bé',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorPalette.pinkBold,
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          height: 0.06,
                          letterSpacing: 0.10,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorPalette.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: ColorPalette.pinklight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //ngang
                  mainAxisAlignment: MainAxisAlignment.center, //dọc
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 14, top: 14, right: 14, bottom: 8),
                      child: Text(
                        'Dịch vụ gần đây',
                        style: TextStyle(
                          color: ColorPalette.blueBold2,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.18,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ColorPalette.pink,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: const CircleBorder(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(9.0),
                                  child: Icon(
                                    Icons.pregnant_woman,
                                    color: ColorPalette.pinkBold,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Gội đầu',
                                  style: TextStyle(
                                    color: ColorPalette.pinkBold,
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0.22,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ColorPalette.pink,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: const CircleBorder(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(9.0),
                                  child: Icon(
                                    Icons.pregnant_woman,
                                    color: ColorPalette.pinkBold,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Gội đầu dưỡng sinh',
                                  style: TextStyle(
                                    color: ColorPalette.pinkBold,
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0.22,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ColorPalette.pink,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: const CircleBorder(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(9.0),
                                  child: Icon(
                                    Icons.pregnant_woman,
                                    color: ColorPalette.pinkBold,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Massage',
                                  style: TextStyle(
                                    color: ColorPalette.pinkBold,
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0.22,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ColorPalette.pink,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: const CircleBorder(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(9.0),
                                  child: Icon(
                                    Icons.child_friendly_sharp,
                                    color: ColorPalette.pinkBold,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Tắm cho bé',
                                  style: TextStyle(
                                    color: ColorPalette.pinkBold,
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0.22,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ColorPalette.pink,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: const CircleBorder(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(9.0),
                                  child: Icon(
                                    Icons.child_friendly,
                                    color: ColorPalette.pinkBold,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Vật lý trị liệu',
                                  style: TextStyle(
                                    color: ColorPalette.pinkBold,
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0.22,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //banner
              const Stack(
                children: [
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Image(
                        width: double.infinity,
                        height: 132,
                        image: AssetImage(AssetHelper.home1),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 12,
                    child: Column(
                      children: [
                        Text(
                          'Đặt lịch đầu tiên của bạn',
                          style: TextStyle(
                            color: ColorPalette.secondaryWhite,
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            height: 0.08,
                            letterSpacing: 0.10,
                          ),
                        ),
                        Text(
                          'và nhiều ưu đã hấp dẫn',
                          style: TextStyle(
                            color: ColorPalette.secondaryWhite,
                            fontSize: 13,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            height: 0.12,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
