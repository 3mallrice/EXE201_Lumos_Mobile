import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/material.dart';

class MyAccountButton extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData? rightIcon;
  final Function()? onPressed;

  const MyAccountButton({
    super.key,
    required this.text,
    required this.leftIcon,
    required this.rightIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 21),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          surfaceTintColor: ColorPalette.blueBold2,
          backgroundColor: ColorPalette.blue2,
          minimumSize: const Size(148, 63),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                leftIcon,
                color: ColorPalette.blueBold2,
                size: 41,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            SizedBox(
              width: 240,
              child: Text(text,
                  style: const TextStyle(
                    color: ColorPalette.blueBold2,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                    letterSpacing: 0.10,
                  )),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                rightIcon,
                color: ColorPalette.pink,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
