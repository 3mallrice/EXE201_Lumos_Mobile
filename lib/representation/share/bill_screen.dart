import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/component/button_bill.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/const/lumos_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  static String routeName = '/bill_screen';

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Hóa đơn',
        leading: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorPalette.bluelight,
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 13,
                    ),
                    decoration: const BoxDecoration(
                      color: ColorPalette.bluelight,
                      border: Border(
                        bottom: BorderSide(
                          color: ColorPalette.secondaryWhite,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: SizedBox(
                            width: 40,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.medical_services_outlined,
                                size: 40,
                                color: ColorPalette.blueBold2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              'Thay băng',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  color: ColorPalette.blueBold2,
                                  fontSize: 16,
                                  //fontFamily: 'verdana',
                                  fontWeight: FontWeight.w400,
                                  height: 0.08,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: 50,
                            child: Text(
                              '500.000',
                              style: TextStyle(
                                color: ColorPalette.blueBold2,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
