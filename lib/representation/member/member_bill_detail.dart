import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';

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
                      fontSize: 24,
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
                const Divider(
                  thickness: 3,
                  height: 2,
                  color: ColorPalette.white,
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
                      'Ngày lên lịch: ',
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
                const CustomerAndService(),
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: FDottedLine(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width * 0.9,
                        strokeWidth: 1.0,
                        dottedLength: 5.0,
                        space: 3.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Tổng tiền dịch vụ: ',
                          style: GoogleFonts.almarai(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.bluelight2,
                            ),
                          ),
                        ),
                        Text(
                          '200.000 đ',
                          style: GoogleFonts.almarai(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.bluelight2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Phụ phí: ',
                          style: GoogleFonts.almarai(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.bluelight2,
                            ),
                          ),
                        ),
                        Text(
                          '30.000 đ',
                          style: GoogleFonts.almarai(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.bluelight2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'Thành tiền: ',
                            style: GoogleFonts.almarai(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.blueBold2,
                              ),
                            ),
                          ),
                          Text(
                            '230.000 đ',
                            style: GoogleFonts.almarai(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.blueBold2,
                              ),
                            ),
                          ),
                        ],
                      ),
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

class CustomerAndService extends StatefulWidget {
  const CustomerAndService({super.key});

  @override
  State<CustomerAndService> createState() => _CustomerAndServiceState();
}

class _CustomerAndServiceState extends State<CustomerAndService> {
  final List<String> _customer = [
    "Nguyễn Vũ Hồng Hoa",
    "Bùi Hữu Phúc",
  ];
  final List<String> _service = [
    "Tắm cho bé",
    "Tắm cho mẹ",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      padding: const EdgeInsets.all(5),
      decoration: ShapeDecoration(
        color: ColorPalette.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _service.length,
        itemBuilder: (context, index) {
          final item = _customer[index];
          return Column(
            children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item,
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.blueBold2),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        clipBehavior: Clip.antiAlias,
                        shrinkWrap: true,
                        itemCount: _service.length,
                        itemBuilder: (context, index) {
                          final item2 = _service[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item2,
                                style: GoogleFonts.almarai(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: ColorPalette.blueBold2,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              if (index < _customer.length - 1)
                const Divider(
                  thickness: 1,
                  height: 2,
                  color: ColorPalette.blue,
                ),
            ],
          );
        },
      ),
    );
  }
}
