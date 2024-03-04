import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:exe201_lumos_mobile/api_model/customer/coming_booking.dart';
import 'package:exe201_lumos_mobile/api_services/booking_service.dart';
import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/back-end/workship.dart';
import 'package:exe201_lumos_mobile/core/const/front-end/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class BookingDetail extends StatefulWidget {
  final int? bookingId;
  const BookingDetail({super.key, this.bookingId});

  static String routeName = '/booking_detail';

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  BookingComing? bookingComing;
  List<MedicalService> medicalService = [];
  List<Service> service = [];

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
      await _fetchBookingDetail(widget.bookingId);
    }
  }

  Future<void> _fetchBookingDetail(int? bookingId) async {
    if (!mounted) return;
    try {
      if (bookingId != null) {
        BookingComing? booking = await api.getBookingDetail(bookingId);
        setState(() {
          bookingComing = booking;
          medicalService = booking.medicalServices;
        });
      } else {
        log.e("Booking id is null.");
        bookingComing = null;
        medicalService = [];
      }
    } catch (e) {
      log.e("Error when fetching booking detail: $e");
      bookingComing = null;
      medicalService = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    String statusText;

    int? status = bookingComing?.status;

    if (status == 2) {
      statusText = 'Đang chờ xác nhận';
    } else if (status == 3) {
      statusText = 'Đang thực hiện';
    } else {
      statusText = 'Trạng thái không hợp lệ';
    }

    return Scaffold(
      appBar: AppBarCom(
        leading: true,
        appBarText: '#${bookingComing?.code ?? ''}',
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              color: ColorPalette.blue2,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookingComing?.partner ?? '',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.blueBold2,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Divider(color: ColorPalette.white, thickness: 2),
                const SizedBox(height: 10),
                Text(
                  'Mã đặt hẹn: #${bookingComing?.code ?? ''}',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: ColorPalette.blueBold2,
                  ),
                  softWrap: true,
                ),
                Text(
                  'Tình trạng: $statusText',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: ColorPalette.blueBold2,
                  ),
                  softWrap: true,
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
                        const SizedBox(width: 10),
                        Text(
                          formatDate(bookingComing?.bookingDate ?? ''),
                          style: GoogleFonts.roboto(
                            color: ColorPalette.blueBold2,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: ColorPalette.blueBold2,
                          size: 15,
                          weight: 5,
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          Icons.circle,
                          color: ColorPalette.blueBold2.withOpacity(0.5),
                          weight: 5,
                          size: 5.5,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          Workshift.workshiftTime[bookingComing?.bookingTime]
                              .toString(),
                          style: GoogleFonts.roboto(
                            color: ColorPalette.blueBold2,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Địa chỉ: ${bookingComing?.address}',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: ColorPalette.blueBold2,
                  ),
                  softWrap: true,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  padding: const EdgeInsets.all(10),
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
                      MedicalService medical = medicalService[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medical.medicalName ?? 'đang phát triển',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.blueBold2,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: medical.services.length,
                            itemBuilder: (context, serviceIndex) {
                              Service service = medical.services[serviceIndex];
                              return ListTile(
                                title: Text(
                                  service.name ?? '',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: ColorPalette.blueBold2,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (index < medicalService.length - 1)
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 1,
                                height: 2,
                                color: ColorPalette.blue,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  'Ghi chú: ${bookingComing?.note ?? 'N/A'}',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: ColorPalette.blueBold2,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.justify,
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
}
