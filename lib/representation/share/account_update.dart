import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/lumos_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class UpdateAccount extends StatefulWidget {
  const UpdateAccount({super.key});

  static String routeName = '/update_account';

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCom(
        appBarText: 'Tài khoản',
        leading: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
