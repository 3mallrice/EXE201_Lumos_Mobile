import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/coming_booking.dart';
import '../../api_services/booking_service.dart';
import '../../core/const/back-end/workship.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'member_booking_all.dart';
import 'member_booking_detail.dart';

import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

class MemberComingBooking extends StatefulWidget {
  const MemberComingBooking({super.key});

  static String routeName = '/member_coming_booking';

  @override
  State<MemberComingBooking> createState() => _MemberBookingState();
}

class _MemberBookingState extends State<MemberComingBooking> {
  List<BookingComing> _comingBooking = [];

  bool isLoaded = false;
  bool isEmtyList = true;

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
            isLoaded = true;
            isEmtyList = comingBooking.isEmpty;
          },
        );
      } else {
        log.e("Error when fetching coming booking: userDetails is null");
        throw Exception(
            "Error when fetching coming booking: userDetails is null");
      }
    } catch (e) {
      setState(() {
        _comingBooking = [];
        isLoaded = true;
        log.e("Error when fetching coming booking: $e");
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondaryWhite,
      appBar: AppBarCom(
        leading: false,
        appBarText: "Lịch hẹn sắp tới",
        action: [
          IconButton(
            splashColor: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pushNamed(MemberAllBooking.routeName);
            },
            icon: Icon(
              Icons.ballot_rounded,
              color: ColorPalette.blueBold2.withOpacity(0.8),
              size: 30,
              weight: 2,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: !isLoaded
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            )
          : isEmtyList
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetHelper.imgLogo,
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Text(
                        "Không có lịch hẹn nào",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                    itemCount: _comingBooking.length,
                    itemBuilder: (context, index) {
                      BookingComing booking = _comingBooking[index];
                      List<MedicalService> medicalServices =
                          booking.medicalServices;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetail(
                                bookingId: booking.bookingId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorPalette.blue2,
                            borderRadius: BorderRadius.circular(11.0),
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
                                              _comingBooking[index].partner ??
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
}
