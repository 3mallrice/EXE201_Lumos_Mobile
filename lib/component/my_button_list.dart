import '../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';

class MyButtonList extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData? rightIcon;
  final Function()? onPressed;

  const MyButtonList({
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  leftIcon,
                  color: ColorPalette.blueBold2,
                  size: 41,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: ColorPalette.blueBold2,
                      fontSize: 18,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w400,
                      height: 0.08,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Icon(
              rightIcon,
              color: ColorPalette.pink,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
