import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/representation/member/search_booking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return PopScope(
      canPop: false,
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Align(
            alignment: AlignmentDirectional.center,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FullScreenImageDialog(
                                imagePath: AssetHelper.memberBanner);
                          },
                        );
                      },
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image(
                          width: double.infinity,
                          image: AssetImage(AssetHelper.memberBanner),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SearchBooking.routeName);
                      },
                      decoration: InputDecoration(
                          hintText: 'Tìm kiếm',
                          hintStyle: GoogleFonts.raleway(
                            color: ColorPalette.pink,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: const Icon(Icons.search_rounded),
                          prefixIconColor: ColorPalette.pink,
                          filled: true,
                          fillColor: ColorPalette.secondaryWhite,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.grey2, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.grey2, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10)),
                    ),
                  ),
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
                              color: ColorPalette.blueBold2,
                              fontSize: 20,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.blue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 2,
                        color: ColorPalette.white,
                      ),
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
                              color: ColorPalette.blueBold2,
                              fontSize: 20,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.blue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
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
                                      backgroundColor: ColorPalette.pink,
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
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w500,
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
                                      backgroundColor: ColorPalette.pink,
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
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
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
                                      backgroundColor: ColorPalette.pink,
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
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w500,
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
                                      backgroundColor: ColorPalette.pink,
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
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
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
                                      backgroundColor: ColorPalette.pink,
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
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w500,
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
                  Stack(
                    children: [
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FullScreenImageDialog(
                                    imagePath: AssetHelper.home1);
                              },
                            );
                          },
                          child: const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: Image(
                              width: double.infinity,
                              height: 132,
                              image: AssetImage(AssetHelper.home1),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Đặt lịch đầu tiên của bạn',
                              style: TextStyle(
                                color: ColorPalette.secondaryWhite,
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'và nhiều ưu đã hấp dẫn',
                              style: TextStyle(
                                color: ColorPalette.secondaryWhite,
                                fontSize: 13,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.blue,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(66.5),
                                  side: const BorderSide(
                                      color: ColorPalette.blue,
                                      width: 2.0), // Border color and width
                                ),
                              ),
                              child: const Text(
                                'Đặt lịch ngay',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorPalette.secondaryWhite,
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, right: 4),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return FullScreenImageDialog(
                                    imagePath: AssetHelper.home2,
                                  );
                                },
                              );
                            },
                            child: const ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              child: Image(
                                width: double.infinity,
                                height: 139,
                                image: AssetImage(AssetHelper.home2),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 4),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return FullScreenImageDialog(
                                    imagePath: AssetHelper.home3,
                                  );
                                },
                              );
                            },
                            child: const ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              child: Image(
                                width: double.infinity,
                                height: 139,
                                image: AssetImage(AssetHelper.home3),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FullScreenImageDialog extends StatelessWidget {
  final String imagePath;

  FullScreenImageDialog({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
