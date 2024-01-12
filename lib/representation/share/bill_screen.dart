import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/component/button_bill.dart';
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
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              MyButtonBill(
                text: 'Chăm sóc người già',
                leftIcon: LumosIcons.plaster_2icon,
                rightIcon: Icons.arrow_forward_ios,
                money: 50.000,
                onPressed: () {
                  //Navigator.of(context).pushNamed(BillScreen.routName);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MyButtonBill(
                text: 'Chăm sóc sau sinh',
                leftIcon: LumosIcons.blood_drip_plusicon,
                rightIcon: Icons.arrow_forward_ios,
                money: 50.000,
                onPressed: () {
                  //Navigator.of(context).pushNamed(BillScreen.routName);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MyButtonBill(
                text: 'Vật lý trị liệu',
                leftIcon: Icons.medical_services_outlined,
                rightIcon: Icons.arrow_forward_ios,
                money: 50.000,
                onPressed: () {
                  //Navigator.of(context).pushNamed(BillScreen.routName);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MyButtonBill(
                text: 'Chăm sóc trẻ',
                leftIcon: LumosIcons.blood_drip_plusicon,
                rightIcon: Icons.arrow_forward_ios,
                money: 50.000,
                onPressed: () {
                  //Navigator.of(context).pushNamed(BillScreen.routName);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MyButtonBill(
                text: 'Thay băng',
                leftIcon: LumosIcons.blood_drip_plusicon,
                rightIcon: Icons.arrow_forward_ios,
                money: 50.000,
                onPressed: () {
                  //Navigator.of(context).pushNamed(BillScreen.routName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
