import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberComingBooking extends StatefulWidget {
  const MemberComingBooking({super.key});

  static String routeName = '/member_coming_booking';

  @override
  State<MemberComingBooking> createState() => _MemberBookingState();
}

class _MemberBookingState extends State<MemberComingBooking> {
  late List<Booking> _bookingsList;

  List<Booking> bookings = [
    Booking(
      hospitalName: 'Bệnh viện ABC',
      appointmentDate: '25/03/2024',
      fromTime: '10:00',
      toTime: '11:00',
      services: ['Dịch vụ A', 'Dịch vụ B'],
      status: 'Đã xác nhận',
    ),
    Booking(
      hospitalName: 'Bệnh viện đa khoa Hữu nghị quốc tế Việt Mỹ',
      appointmentDate: '25/03/2024',
      fromTime: '10:00',
      toTime: '11:00',
      services: [
        'Tắm cho mẹ bầu',
        'Tắm cho bé lớn hơn 3 tháng tuổi',
        'Massage mẹ bầu và bé lớn hơn 3 tháng tuổi',
        'Dịch vụ C',
        'Dịch vụ A',
        'Dịch vụ C'
      ],
      status: 'Đã xác nhận',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _bookingsList = bookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCom(
        leading: false,
        appBarText: "Lịch đặt sắp tới",
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
        itemCount: _bookingsList.length,
        itemBuilder: (context, index) {
          Booking booking = _bookingsList[index];
          return Container(
            margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorPalette.blue2,
              borderRadius: BorderRadius.circular(11.0),
            ),
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
                                booking.hospitalName,
                                style: const TextStyle(
                                  color: ColorPalette.blueBold2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
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
                                        booking.appointmentDate.toString(),
                                        style: const TextStyle(
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
                                    color:
                                        ColorPalette.blueBold2.withOpacity(0.5),
                                    weight: 5,
                                    size: 5.5,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${booking.fromTime} - ${booking.toTime}',
                                    style: const TextStyle(
                                      color: ColorPalette.blueBold2,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              for (var service in booking.services)
                                Text(
                                  service,
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      color: ColorPalette.blueBold2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                          Icons.volunteer_activism_outlined,
                          color: ColorPalette.blueBold2,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Booking {
  final String hospitalName;
  final String appointmentDate;
  final String fromTime;
  final String toTime;
  final List<String> services;
  final String status;

  Booking({
    required this.hospitalName,
    required this.appointmentDate,
    required this.fromTime,
    required this.toTime,
    required this.services,
    required this.status,
  });
}
