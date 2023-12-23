import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/const/textstyle_const.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.title, this.ontap})
      : super(key: key);

  final String title;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: Gradients.button, //cách dùng màu gradient
      ),
      child: MaterialButton(
        minWidth: 0, // Đặt chiều ngang tối thiểu để fit chữ
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
