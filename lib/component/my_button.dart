import '../core/const/front-end/color_const.dart';
import 'package:flutter/cupertino.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  final double borderRadius;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? horizontalPadding;
  final Color color;
  final Widget widget;

  const MyButton({
    super.key,
    required this.onTap,
    this.borderColor = ColorPalette.white,
    this.height,
    this.width,
    this.horizontalPadding,
    required this.borderRadius,
    required this.color,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 40.0),
        child: Container(
          width: width ?? 324,
          height: height ?? 58,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor as Color, width: 1),
          ),
          child: Center(child: widget),
        ),
      ),
    );
  }
}
