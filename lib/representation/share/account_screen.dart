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
    return const Scaffold(
      appBar: AppBarCom(
        appBarText: 'Account',
      ),
    );
  }
}
