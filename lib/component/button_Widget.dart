import 'package:flutter/material.dart';

import '../core/const/front-end/color_const.dart';
import '../core/const/front-end/textstyle_const.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.title, this.ontap});

  final String title;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: ColorPalette.pink,
      ),
      child: MaterialButton(
        minWidth: 0,
        height: 40,
        onPressed: ontap,
        child: Text(
          title,
          style: TextStyles.defaultStyle.bold.whiteTextColor,
        ),
      ),
    );
  }
}
