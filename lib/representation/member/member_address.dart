import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:flutter/material.dart';

class MemberAddress extends StatefulWidget {
  const MemberAddress({super.key});

  static String routeName = '/member_address';

  @override
  State<MemberAddress> createState() => _MemberAddressState();
}

class _MemberAddressState extends State<MemberAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        leading: false,
        appBarText: 'Thông báo',
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
