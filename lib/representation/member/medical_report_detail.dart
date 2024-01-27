import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:flutter/material.dart';

class MedicalReportDetail extends StatelessWidget {
  const MedicalReportDetail({super.key});

  static String routeName = '/medical_report_detail';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCom(
        leading: true,
        appBarText: "Hồ sơ bệnh nhân",
      ),
      body: Column(),
    );
  }
}
