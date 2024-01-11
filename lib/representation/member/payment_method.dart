import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  static String routeName = '/payment_method';

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCom(
        appBarText: "Phương thức thanh toán",
        leading: true,
      ),
    );
  }
}
