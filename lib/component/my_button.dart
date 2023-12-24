import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/cupertino.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;
  final Color textColor;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
