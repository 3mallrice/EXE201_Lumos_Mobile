import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report_update.dart';
import 'package:flutter/material.dart';

class MedicalReportDetail extends StatelessWidget {
  const MedicalReportDetail({super.key});

  static String routeName = '/medical_report_detail';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppBarCom(
        leading: true,
        appBarText: "Hồ sơ bệnh nhân",
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth * 0.9,
            margin: const EdgeInsets.only(top: 20),
            child: const Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Nguyễn Đinh Phương Thảo Trang',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: ColorPalette.pinkBold,
                      ),
                      softWrap: true,
                    )
                  ],
                ),
                SizedBox(
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                        Text(
                          'Anh',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Raleway',
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Giới tính: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                        Text(
                          'Nam',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Raleway',
                            color: ColorPalette.blueBold2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Ngày sinh: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    Text(
                      '19/05/1989',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins',
                        color: ColorPalette.blueBold2,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Nhóm máu: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    Text(
                      'B Rh+',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Raleway',
                        color: ColorPalette.blueBold2,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Số điện thoại: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    Text(
                      '0934853348',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins',
                        color: ColorPalette.blueBold2,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghi chú: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hoàn toàn bình thường, khoẻ mạnh Hoàn toàn bình thường, khoẻ mạnh Hoàn toàn bình thường, khoẻ mạnh Hoàn toàn bình thường, khoẻ mạnh',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Raleway',
                        color: ColorPalette.blueBold2,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  ],
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
              Navigator.of(context).pushNamed(MedicalReportUpdate.routeName);
              print('Button pressed');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPalette.pink,
              padding: const EdgeInsets.all(12),
              minimumSize: Size(100, 40),
            ),
            child: const Text(
              'Chỉnh sửa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Raleway',
                color: ColorPalette.secondaryWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
