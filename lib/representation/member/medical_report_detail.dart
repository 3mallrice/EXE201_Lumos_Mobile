import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report.dart';
import 'package:exe201_lumos_mobile/representation/share/account_screen.dart';
import 'package:flutter/material.dart';

class MedicalReportDetail extends StatelessWidget {
  const MedicalReportDetail({super.key});

  static String routeName = '/medical-report-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        leading: true,
        appBarText: "Hồ sơ bệnh nhân",
      ),
    );
  }
}
