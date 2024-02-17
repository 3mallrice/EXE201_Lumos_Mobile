import 'package:flutter/material.dart';
import '../core/const/front-end/color_const.dart';

class MyButtonBill extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData? rightIcon;
  final double money;
  final Function()? onPressed;

  const MyButtonBill({
    super.key,
    required this.text,
    required this.leftIcon,
    required this.rightIcon,
    required this.onPressed,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          surfaceTintColor: ColorPalette.blueBold2,
          backgroundColor: ColorPalette.blue2,
          minimumSize: const Size(336, 35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 1,
              child: Icon(
                leftIcon,
                color: ColorPalette.blueBold2,
                size: 35,
              ),
            ),
            SizedBox(
              width: 117,
              height: 23,
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF0A4F45),
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
            ),
            SizedBox(
              width: 50,
              height: 19,
              child: Text(
                '₫${money.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF0A4F45),
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                rightIcon,
                color: ColorPalette.pink,
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
