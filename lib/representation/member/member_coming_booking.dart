import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:exe201_lumos_mobile/api_model/customer/coming_booking.dart';
import 'package:exe201_lumos_mobile/api_services/booking_service.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';

import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class MemberComingBooking extends StatefulWidget {
  const MemberComingBooking({super.key});

  static String routeName = '/member_coming_booking';

  @override
  State<MemberComingBooking> createState() => _MemberBookingState();
}

class _MemberBookingState extends State<MemberComingBooking> {
  List<BookingComing> _comingBooking = [];
  List<MedicalService> _service = [];
  List<Service> _service2 = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  bool _isEmptyList = true;
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
      _fetchComingBooking();
    }
  }

  void _fetchComingBooking() async {
    try {
      if (userDetails != null) {
        List<BookingComing>? comingBooking = await api.getBookingComing();
        setState(
          () {
            _comingBooking = comingBooking;
            _isEmptyList = _comingBooking.isEmpty;
          },
        );
      } else {
        setState(
          () {
            log.e("User details or user id is null.");
            _comingBooking = [];
            _isEmptyList = true;
          },
        );
      }
    } catch (e) {
      setState(
        () {
          log.e("Error when fetching coming booking: $e");
          _comingBooking = [];
          _isEmptyList = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCom(
        leading: false,
        appBarText: "Lịch bạn đã đặt",
        action: [
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {},
            icon: Icon(
              Icons.ballot_rounded,
              color: ColorPalette.blueBold2.withOpacity(0.9),
              size: 30,
              weight: 2,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _comingBooking.length,
        itemBuilder: (context, index) {
          BookingComing booking = _comingBooking[index];

          _service = _comingBooking[index].medicalServices;
          _service2 = _comingBooking[index].medicalServices[0].services;
          final item = _service[index];
          return Container(
            margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorPalette.blue2,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MemberBookingDetail(
                //       booking: booking,
                //     ),
                //   ),
                // );
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cột 1 - Thông tin về booking
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.partner ?? "đang cập nhật",
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
                                      MainAxisAlignment.spaceBetween,
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
                                          booking.bookingDate.toString(),
                                          style: GoogleFonts.roboto(
                                            color: ColorPalette.blueBold2,
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
                                      color: ColorPalette.blueBold2,
                                      size: 15,
                                      weight: 5,
                                    ),
                                    const SizedBox(width: 3),
                                    Icon(
                                      Icons.circle,
                                      color: ColorPalette.blueBold2
                                          .withOpacity(0.5),
                                      weight: 5,
                                      size: 5.5,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      booking.bookingTime.toString(),
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.blueBold2,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.medicalName ?? '',
                                              style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorPalette.blueBold2,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: _service2.map((item2) {
                                                return Text(
                                                  item2.name ?? '',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: ColorPalette
                                                          .blueBold2,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
                          transform: Matrix4.rotationY(185), // Lật theo trục Y
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
    );
  }
}
