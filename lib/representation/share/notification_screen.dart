import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/representation/member/medical_report_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static String routeName = '/notification_screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> _notis = [
      "Chào mừng bạn đến với Lumos",
      "Hãy chia sẻ Lumos đến với bạn bè của bạn nhé",
      "Chúc bạn một ngày tối lành",
      "Chúc bạn đầu tuần tốt lành",
      "Cảm ơn bạn đã sử dụng dịch vụ của Lumos",
      "Hôm nay trời rất lạnh, bạn nhớ mặc ấm nhé",
      "Chào mừng bạn đến với Lumos",
      "Hãy chia sẻ Lumos đến với bạn bè của bạn nhé",
      "Chúc bạn một ngày tối lành",
      "Chúc bạn đầu tuần tốt lành",
      "Cảm ơn bạn đã sử dụng dịch vụ của Lumos",
      "Hôm nay trời rất lạnh, bạn nhớ mặc ấm nhé",
      "Chào mừng bạn đến với Lumos",
      "Hãy chia sẻ Lumos đến với bạn bè của bạn nhé",
      "Chúc bạn một ngày tối lành",
      "Chúc bạn đầu tuần tốt lành",
      "Cảm ơn bạn đã sử dụng dịch vụ của Lumos",
      "Hôm nay trời rất lạnh, bạn nhớ mặc ấm nhé",
      "Chào mừng bạn đến với Lumos",
      "Hãy chia sẻ Lumos đến với bạn bè của bạn nhé",
      "Chúc bạn một ngày tối lành",
      "Chúc bạn đầu tuần tốt lành",
      "Cảm ơn bạn đã sử dụng dịch vụ của Lumos",
      "Hôm nay trời rất lạnh, bạn nhớ mặc ấm nhé",
    ];
    return Scaffold(
      appBar: const AppBarCom(
        leading: false,
        appBarText: 'Thông báo',
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        color: ColorPalette.bluelight,
        child: ListView.builder(
          clipBehavior: Clip.antiAlias,
          shrinkWrap: true,
          itemCount: _notis.length,
          itemBuilder: (context, index) {
            final item = _notis[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MedicalReportDetail.routeName);
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications,
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
                if (index < _notis.length - 1)
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
    );
  }
}
