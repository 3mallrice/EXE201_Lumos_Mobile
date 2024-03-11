import '../../api_model/authentication/login.dart';
import '../../api_model/customer/bill.dart';
import '../../api_services/booking_service.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import '../member/member_bill_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  static String routeName = '/bill_screen';

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  List<Billing>? bills = [];

  CallBookingApi api = CallBookingApi();
  var log = Logger();
  bool isEmptyList = true;
  bool isDataLoaded = false;

  UserDetails? userDetails;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void _fetchUserData() async {
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.of(context).pushReplacementNamed(Login.routeName);
        },
      );
    } else {
      await _fetchBookings();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }
  }

  Future<void> _fetchBookings() async {
    try {
      if (userDetails != null) {
        List<Billing> billing = await api.getBillings();
        setState(
          () {
            bills = billing;
            isDataLoaded = true;
          },
        );
      } else {
        log.e("User details or user id is null.");
        throw Exception("User details or user id is null.");
      }
    } catch (e) {
      log.e("Error when fetching billings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Danh sách hóa đơn',
        leading: true,
      ),
      body: !isDataLoaded
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            )
          : Container(
              margin: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: bills!.length,
                itemBuilder: (context, index) {
                  Billing bill = bills![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BillDetail(
                            billId: bill.bookingId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: ColorPalette.bluelight,
                        borderRadius: BorderRadius.circular(11.0),
                        border: Border.all(
                          color: getStatusColor(bill.status),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorPalette.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bill.partnerName,
                            style: GoogleFonts.roboto(
                              textStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.blueBold2,
                                fontSize: 20,
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
                                size: 16,
                                weight: 1.4,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "#${bill.bookingCode}",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    color: ColorPalette.blueBold2,
                                    fontSize: 16,
                                  ),
                                ),
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
                                    size: 16,
                                    weight: 1.4,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    formatDate(bill.bookingDate),
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        color: ColorPalette.blueBold2,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ghi chú:",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    color: ColorPalette.blueBold2,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                bill.note ?? "Không có ghi chú",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    color: ColorPalette.blueBold2,
                                    fontSize: 16,
                                  ),
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const Divider(
                            color: ColorPalette.white,
                            thickness: 2,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '₫ ${formatCurrency(bill.totalPrice)}',
                                  style: const TextStyle(
                                    color: ColorPalette.blueBold2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String formatCurrency(int amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return ColorPalette.pinkBold;
      case 0:
      case 2:
      case 3:
      case 4:
      case 5:
        return ColorPalette.blue2;
      default:
        return ColorPalette.blue2;
    }
  }
}
