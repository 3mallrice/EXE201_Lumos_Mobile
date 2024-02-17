import '../core/const/front-end/color_const.dart';
import 'package:flutter/cupertino.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  final double borderRadius;
  final Color? borderColor;
  final double? height;
  final double? width;
  final Color color;
  final Widget widget;

  const MyButton({
    super.key,
    required this.onTap,
    this.borderColor = ColorPalette.white,
    this.height,
    this.width,
    required this.borderRadius,
    required this.color,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 324,
        height: 58,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor as Color, width: 1),
        ),
        child: Center(child: widget),
      ),
    );
  }
}
