import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:flutter/material.dart';
import 'package:exe201_lumos_mobile/component/app_bar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  static String routeName = '/account_screen';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Tài khoản',
      ),
      body: Column(
        children: [
          SizedBox(height: 28),
          Center(
            child: Column(
              children: [
                Container(
                  width: 121,
                  height: 121,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AssetHelper.accountImg),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 132,
                  height: 23,
                  child: Text(
                    'Leslie Alexander',
                    style: TextStyle(
                      color: Color(0xFF0A4F45),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.08,
                      letterSpacing: 0.10,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
