import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/representation/member/member_bill_detail.dart';
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
      partner: "Bệnh viện sản nhi trung ương Tp.Hồ Chí Minh",
      bookingId: "Lumos.1.24.000001",
      bookingDate:
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      note: "",
      totalPrice: "500.000",
    ),
    Bill(
      partner: "Phòng khám Hạnh Phúc",
      bookingId: "Lumos.1.24.000002",
      bookingDate:
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      note: "",
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
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 10,
          right: 20,
          left: 20,
        ),
        child: ListView.builder(
          itemCount: bills.length,
          itemBuilder: (context, index) {
            Bill bill = bills[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(BillDetail.routeName);
              },
              child: Container(
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
                      bill.partner,
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.blueBold2,
                          fontSize: 21,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.bookmarks_sharp,
                          color: ColorPalette.blueBold2,
                          size: 15,
                          weight: 1.4,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "#${bill.bookingId}",
                          style: const TextStyle(
                            color: ColorPalette.blueBold2,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          "đ",
                          style: GoogleFonts.almarai(
                            textStyle: const TextStyle(
                                color: ColorPalette.blueBold2,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_sharp,
                              color: ColorPalette.blueBold2,
                              size: 15,
                              weight: 1.4,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              bill.bookingDate.toString(),
                              style: const TextStyle(
                                color: ColorPalette.blueBold2,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      "Ghi chú:",
                      style: TextStyle(
                        color: ColorPalette.blueBold2,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      bill.note,
                      style: const TextStyle(
                        color: ColorPalette.blueBold2,
                        fontSize: 15,
                      ),
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Bill {
  String partner;
  String bookingId;
  String bookingDate;
  String note;
  String totalPrice;

  Bill({
    required this.partner,
    required this.bookingId,
    required this.bookingDate,
    required this.note,
    required this.totalPrice,
  });
}
