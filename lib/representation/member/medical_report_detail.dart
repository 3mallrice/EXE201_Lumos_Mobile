import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rich_readmore/rich_readmore.dart';

import '../../api_model/customer/medical_report.dart';
import '../../component/app_bar.dart';
import '../../core/const/back-end/reponse_text.dart';
import '../../core/const/front-end/color_const.dart';

class MedicalReportDetail extends StatelessWidget {
  const MedicalReportDetail({super.key});

  static String routeName = '/medical_report_detail';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final MedicalReport? medicalReport =
        ModalRoute.of(context)?.settings.arguments as MedicalReport?;

    if (medicalReport == null) {
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: const AppBarCom(
        leading: true,
        appBarText: "Hồ sơ hồ sơ",
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth * 0.9,
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      medicalReport!.fullname,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.pinkBold,
                      ),
                      softWrap: true,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Danh xưng: ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                        Text(
                          Constansts._listPro[medicalReport.pronounce],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Giới tính: ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                        Text(
                          (medicalReport.gender) ? 'Nam' : 'Nữ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Ngày sinh: ',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(medicalReport.dob),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: ColorPalette.blueBold2,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Nhóm máu: ',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    Text(
                      Constansts._listBlood[medicalReport.bloodType],
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: ColorPalette.blueBold2,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Số điện thoại: ',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    Text(
                      medicalReport.phone.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: ColorPalette.blueBold2,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Ghi chú: ',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.blueBold2,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      RichReadMoreText.fromString(
                        text: medicalReport.note!,
                        textStyle: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: ColorPalette.bluelight2,
                            decorationStyle: TextDecorationStyle.solid,
                            textStyle: const TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                            )),
                        settings: LineModeSettings(
                          trimLines: 5,
                          trimCollapsedText: 'Xem thêm',
                          trimExpandedText: 'Rút gọn',
                          lessStyle: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: ColorPalette.bluelight2,
                          ),
                          moreStyle: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: ColorPalette.bluelight2,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(MedicalReportUpdate.routeName);
              //show dialog said in development
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      OnDevelopmentMessage.fearureOnDevelopmentTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    content: const Text(
                      OnDevelopmentMessage.featureOnDevelopment,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPalette.pink,
              padding: const EdgeInsets.all(12),
              minimumSize: const Size(100, 40),
            ),
            child: Text(
              'Chỉnh sửa',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: ColorPalette.blueBold2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Constansts {
  static const List<String> _listPro = [
    'Ông',
    'Bà',
    'Bé',
    'Anh',
    'Chị',
  ];

  static const List<String> _listBlood = [
    'Nhóm A Rh+',
    'Nhóm A Rh-',
    'Nhóm B Rh-',
    'Nhóm B Rh-',
    'Nhóm O Rh+',
    'Nhóm O Rh-',
    'Nhóm AB Rh+',
    'Nhóm AB Rh-',
  ];
}
