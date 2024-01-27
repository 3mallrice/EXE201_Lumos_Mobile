import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  static String routeName = '/bill_screen';

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final List<Bill> bills = [
    Bill(
      service: "Tắm bé lớn hơn 3 tháng tuổi",
      partner: "Bệnh viện sản nhi trung ương Tp.Hồ Chí Minh",
      bookingDate:
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      from: "10:30",
      to: "14:00",
      totalPrice: "500.000",
    ),
    Bill(
      service: "Chăm sóc mẹ bầu",
      partner: "Phòng khám Hạnh Phúc",
      bookingDate:
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      from: "8:00",
      to: "9:30",
      totalPrice: "500.000",
    ),
    // Add more Bill objects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Hóa đơn',
        leading: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
        child: ListView.builder(
          itemCount: bills.length,
          itemBuilder: (context, index) {
            Bill bill = bills[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: ColorPalette.bluelight,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.service,
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.blueBold2,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    bill.partner,
                    style: const TextStyle(
                      color: ColorPalette.blueBold2,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ngày đặt: ${bill.bookingDate.toString()}',
                        style: const TextStyle(
                          color: ColorPalette.blueBold2,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: ColorPalette.blueBold2,
                            size: 16,
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.circle,
                            color: ColorPalette.blueBold2.withOpacity(0.5),
                            size: 5.5,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${bill.from} - ${bill.to}',
                            style: const TextStyle(
                              color: ColorPalette.blueBold2,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(
                    color: ColorPalette.white,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          bill.totalPrice.toString(),
                          style: const TextStyle(
                            color: ColorPalette.blueBold2,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          "đ",
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                                color: ColorPalette.blueBold2,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Bill {
  String service;
  String partner;
  String bookingDate;
  String from;
  String to;
  String totalPrice;

  Bill({
    required this.service,
    required this.partner,
    required this.bookingDate,
    required this.from,
    required this.to,
    required this.totalPrice,
  });
}
