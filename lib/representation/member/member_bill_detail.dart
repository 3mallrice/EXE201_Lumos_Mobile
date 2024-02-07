import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillDetail extends StatefulWidget {
  const BillDetail({super.key});

  static String routeName = '/bill_detail';

  @override
  State<BillDetail> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Hóa đơn',
        leading: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: ColorPalette.blue2,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bệnh viện sản nhi trung ương TP Hồ Chí Minh',
                  style: GoogleFonts.almarai(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.blueBold2,
                    ),
                  ),
                ),
                Text(
                  '28/10/2023 - 10:21',
                  style: GoogleFonts.almarai(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.blueBold2,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Mã đặt chỗ: ',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.bluelight2,
                        ),
                      ),
                    ),
                    Text(
                      '#BOKVN2412345',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Ngày tạo đặt chỗ: ',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.bluelight2,
                        ),
                      ),
                    ),
                    Text(
                      '26/10/2023 - 09:45',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ: ',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.bluelight2,
                        ),
                      ),
                    ),
                    Text(
                      '10 Bùi Viện, Quận 1, TP. Hồ Chí Minh',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomerAndService(),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghi chú: ',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.bluelight2,
                        ),
                      ),
                    ),
                    Text(
                      'Khỏe mạnh, khỏe mạnh khỏe mạnh Khỏe mạnh, khỏe mạnh khỏe mạnh Khỏe mạnh, khỏe mạnh khỏe mạnh Khỏe mạnh, khỏe mạnh khỏe mạnh',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerAndService extends StatelessWidget {
  const CustomerAndService({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: ColorPalette.blue2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
