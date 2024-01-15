import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/component/button_bill.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/const/lumos_icons.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        margin: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.bluelight,
                border: const Border(
                  bottom: BorderSide(
                    color: ColorPalette.secondaryWhite,
                    width: 2,
                  ),
                ),
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
