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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Your logic here
                    },
                    icon: const Icon(
                      Icons.pregnant_woman,
                      color: ColorPalette.blueBold2,
                    ),
                    label: const Text(
                      'Mẹ bầu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0A4F45),
                        fontSize: 20,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                        letterSpacing: 0.10,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorPalette.blue,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.4,
                        50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Your logic here
                    },
                    icon: const Icon(
                      Icons.child_friendly,
                      color: ColorPalette.blueBold2,
                    ),
                    label: const Text(
                      'Em bé',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0A4F45),
                        fontSize: 20,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                        letterSpacing: 0.10,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorPalette.blue,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.4,
                        50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorPalette.pinklight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //ngang
                  mainAxisAlignment: MainAxisAlignment.center, //dọc
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'Dịch vụ gần đây',
                        style: TextStyle(
                          color: Color(0xFF0A4F45),
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.18,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
