import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:exe201_lumos_mobile/api_model/customer/billdetail.dart';
import 'package:exe201_lumos_mobile/api_services/booking_service.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';

class BillDetail extends StatefulWidget {
  final int? billId;
  const BillDetail({super.key, this.billId});

  static String routeName = '/bill_detail';

  @override
  State<BillDetail> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  BillDetailId? _billing;
  List<MedicalServices> medicalService = [];
  List<Servicess> service = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  CallBookingApi api = CallBookingApi();
  var log = Logger();

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
      await _fetchBillingDetail(widget.billId);
    }
  }

  Future<void> _fetchBillingDetail(int? bookingId) async {
    if (!mounted) return;
    try {
      if (bookingId != null) {
        BillDetailId? billing = await api.getBillingDetail(bookingId);
        setState(() {
          _billing = billing;
          medicalService = billing.medicalServices;
        });
      } else {
        log.e("Booking id is null.");
        _billing = null;
        medicalService = [];
      }
    } catch (e) {
      log.e("Error when fetching billing detail: $e");
      _billing = null;
      medicalService = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCom(
        appBarText: '#${_billing?.bookingCode ?? ''}',
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
                  _billing?.partner ?? 'đang cập nhật',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.blueBold2,
                    ),
                  ),
                ),
                Text(
                  formatDate(_billing!.bookingDate),
                  style: GoogleFonts.roboto(
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
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.bluelight2,
                        ),
                      ),
                    ),
                    Text(
                      '#${_billing?.bookingCode ?? ''}',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.baseline,
                //   textBaseline: TextBaseline.alphabetic,
                //   children: [
                //     Text(
                //       'Ngày lên lịch: ',
                //       style: GoogleFonts.roboto(
                //         textStyle: const TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.normal,
                //           color: ColorPalette.bluelight2,
                //         ),
                //       ),
                //     ),
                //     Text(
                //       '26/10/2023 - 09:45',
                //       style: GoogleFonts.roboto(
                //         textStyle: const TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           color: ColorPalette.blueBold2,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ: ',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.bluelight2,
                        ),
                      ),
                    ),
                    Text(
                      _billing?.address ?? 'đang cập nhật',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: ShapeDecoration(
                    color: ColorPalette.bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: medicalService.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  medicalService[index].medicalName,
                                  style: GoogleFonts.roboto(
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
                                    itemCount: service.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            service[index].name,
                                            style: GoogleFonts.roboto(
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
                          if (index < medicalService.length - 1)
                            const Divider(
                              thickness: 1,
                              height: 2,
                              color: ColorPalette.blue,
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghi chú: ',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.bluelight2,
                        ),
                      ),
                    ),
                    Text(
                      _billing?.note ?? 'đang cập nhật',
                      style: GoogleFonts.roboto(
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
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.bluelight2,
                            ),
                          ),
                        ),
                        Text(
                          '₫ ${formatCurrency(_billing!.totalPrice)}',
                          style: GoogleFonts.roboto(
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
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.bluelight2,
                            ),
                          ),
                        ),
                        Text(
                          '₫ ${formatCurrency(_billing!.additionalFee) ?? 0}',
                          style: GoogleFonts.roboto(
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
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.blueBold2,
                              ),
                            ),
                          ),
                          Text(
                            '230.000 đ',
                            style: GoogleFonts.roboto(
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String formatCurrency(int amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }
}
