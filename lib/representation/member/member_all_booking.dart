import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:exe201_lumos_mobile/api_services/booking_service.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MemberAllBooking extends StatefulWidget {
  const MemberAllBooking({super.key});

  static String routeName = '/member_all_booking';
  @override
  State<MemberAllBooking> createState() => _MemberAllBookingState();
}

class _MemberAllBookingState extends State<MemberAllBooking> {
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
      //_fetchComingBooking();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
