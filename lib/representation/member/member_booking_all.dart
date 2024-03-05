import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:exe201_lumos_mobile/api_model/customer/coming_booking.dart';
import 'package:exe201_lumos_mobile/api_services/booking_service.dart';
import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/back-end/workship.dart';
import 'package:exe201_lumos_mobile/core/const/front-end/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/member/member_booking_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

import '../../core/helper/asset_helper.dart';

class MemberAllBooking extends StatefulWidget {
  const MemberAllBooking({super.key});

  static String routeName = '/all_booking';

  @override
  State<MemberAllBooking> createState() => _MemberAllBookingState();
}

class _MemberAllBookingState extends State<MemberAllBooking> {
  List<BookingComing> _bookings = [];

  CallBookingApi api = CallBookingApi();
  var log = Logger();
  bool isEmptyList = true;
  bool isLoaded = false;

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
      _fetchBookings();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchBookings() async {
    try {
      if (userDetails != null) {
        List<BookingComing>? bookings = await api.getBookings();
        setState(
          () {
            _bookings = bookings;
            isLoaded = true;
            isEmptyList = _bookings.isEmpty;
          },
        );
      } else {
        log.e("User details or user id is null.");
        throw Exception("User details or user id is null.");
      }
    } catch (e) {
      log.e("Error when fetching bookings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondaryWhite,
      appBar: const AppBarCom(
        appBarText: "Lịch bạn đã đặt",
        leading: true,
      ),
      body: !isLoaded
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            )
          : isEmptyList
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetHelper.imgLogo,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Text(
                      "Bạn chưa có lịch đặt nào",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.blueBold2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ))
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      BookingComing booking = _bookings[index];
                      List<MedicalService> medicalServices =
                          booking.medicalServices;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorPalette.blue2,
                          borderRadius: BorderRadius.circular(11.0),
                          border: Border.all(
                            color: getStatusColor(booking.status!),
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDetail(
                                  bookingId: booking.bookingId!,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Cột 1 - Thông tin về booking
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _bookings[index].partner ??
                                                  "Đang cập nhật",
                                              style: GoogleFonts.roboto(
                                                color: ColorPalette.blueBold2,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .calendar_month_sharp,
                                                          color: ColorPalette
                                                              .blueBold2,
                                                          size: 15,
                                                          weight: 1.4,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          formatDate(booking
                                                              .bookingDate!),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: ColorPalette
                                                                .blueBold2,
                                                            fontSize: 15,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.access_time,
                                                      color: ColorPalette
                                                          .blueBold2,
                                                      size: 15,
                                                      weight: 5,
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Icon(
                                                      Icons.circle,
                                                      color: ColorPalette
                                                          .blueBold2
                                                          .withOpacity(0.5),
                                                      weight: 5,
                                                      size: 5.5,
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      Workshift.workshiftTime[
                                                              booking
                                                                  .bookingTime]
                                                          .toString(),
                                                      style: GoogleFonts.roboto(
                                                        color: ColorPalette
                                                            .blueBold2,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            ListTile(
                                              title: GestureDetector(
                                                onTap: () {},
                                                child: ListTile(
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children:
                                                        medicalServices.map(
                                                      (report) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              report.medicalName ??
                                                                  '',
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: ColorPalette
                                                                      .blueBold2,
                                                                ),
                                                              ),
                                                            ),
                                                            ...report.services
                                                                .map(
                                                              (service) {
                                                                return Text(
                                                                  service.name ??
                                                                      '',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: ColorPalette
                                                                          .blueBold2,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                          ],
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 1.0,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(
                                          185), // Lật theo trục Y
                                      child: const Icon(
                                        Icons.medical_information_outlined,
                                        color: ColorPalette.blueBold2,
                                        size: 40,
                                      ),
                                    ),
                                  )
                                ],
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

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return ColorPalette.pinkBold;
      case 2:
      case 3:
        return ColorPalette.blue2;
      case 4:
      case 5:
        return ColorPalette.white;
      default:
        return ColorPalette.blue2;
    }
  }
}
