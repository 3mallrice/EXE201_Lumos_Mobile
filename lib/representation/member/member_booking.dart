import 'package:exe201_lumos_mobile/representation/member/payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberBooking extends StatefulWidget {
  const MemberBooking({super.key});

  static String routeName = '/member_booking';

  @override
  State<MemberBooking> createState() => _MemberBookingState();
}

class _MemberBookingState extends State<MemberBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(PaymentMethod.routeName);
        },
        child: Text("Go to Payment Method"),
      ),
    );
  }
}
