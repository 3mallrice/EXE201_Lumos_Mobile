import '../../api_model/customer/medical_report.dart';
import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'medical_report_addnew.dart';
import 'medical_report_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_services/customer_service.dart';

class MedicalReportPage extends StatefulWidget {
  const MedicalReportPage({super.key});

  static String routeName = '/medical_report';

  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {
  @override
  Widget build(BuildContext context) {
    List<String> _reports = [];

    CallCustomerApi api = CallCustomerApi();

    void _fetchMedicalReports() async {
      try {
        // Gọi API để lấy danh sách bệnh nhân
        List<MedicalReport> reports = await api.getMedicalReport(1);
        List<String> reportNames = reports.map((e) => e.fullname).toList();
        setState(() {
          _reports = reportNames; // Cập nhật danh sách bệnh nhân vào State
        });
      } catch (e) {
        // Xử lý lỗi, dont print
      }
    }

    return Scaffold(
      appBar: const AppBarCom(
        appBarText: "Danh sách bệnh nhân",
        leading: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: ColorPalette.blue2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: ListView.builder(
          clipBehavior: Clip.antiAlias,
          shrinkWrap: true,
          itemCount: _reports.length,
          itemBuilder: (context, index) {
            final item = _reports[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MedicalReportDetail.routeName);
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.medical_services,
                      size: 23,
                      color: ColorPalette.pink,
                    ),
                    title: Text(
                      item,
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.blueBold2),
                      ),
                    ),
                  ),
                ),
                if (index < _reports.length - 1)
                  const Divider(
                    thickness: 2,
                    height: 2,
                    color: ColorPalette.white,
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(MedicalReportAdd.routeName);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalette.pink,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: ColorPalette.white,
          ),
        ),
      ),
    );
  }
}
