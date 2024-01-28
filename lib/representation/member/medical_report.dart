import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report_addnew.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalReport extends StatelessWidget {
  const MedicalReport({super.key});

  static String routeName = '/medical-report';

  @override
  Widget build(BuildContext context) {
    List<String> _reports = [
      "Nguyễn Vũ Hồng Hoa",
      "Bùi Hữu Phúc",
      "Bùi Hữu Đức",
      "Lê Thị Diễm Trinh",
      "Bùi Thanh Tú",
      "Nguyễn Văn Tiến",
      "Lương Tuyết Trang",
      "Nguyễn Vũ Hồng Hoa",
      "Bùi Hữu Phúc",
      "Bùi Hữu Đức",
      "Lê Thị Diễm Trinh",
      "Bùi Thanh Tú",
      "Nguyễn Văn Tiến",
      "Lương Tuyết Trang",
      "Nguyễn Vũ Hồng Hoa",
      "Bùi Hữu Phúc",
      "Bùi Hữu Đức",
      "Lê Thị Diễm Trinh",
      "Bùi Thanh Tú",
      "Nguyễn Văn Tiến",
      "Lương Tuyết Trang"
    ];

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
                      style: GoogleFonts.raleway(
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
            print('Button pressed');
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
