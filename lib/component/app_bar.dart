import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/const/color_const.dart';

class AppBarCom extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarText;
  final bool leading;
  final Widget? leftIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final List<Widget>? action;

  const AppBarCom({
    super.key,
    this.appBarText,
    this.leading = false,
    this.leftIcon,
    this.backgroundColor,
    this.textColor,
    this.action,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: leading,
        leading: leftIcon ?? const Icon(Icons.arrow_back_ios_rounded),
        iconTheme: const IconThemeData(color: ColorPalette.secondaryWhite),
        backgroundColor: backgroundColor ?? ColorPalette.blue,
        title: Text(
          appBarText ?? "",
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
                color: textColor ?? ColorPalette.blueBold2,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 4,
        actions: action,
      ),
    );
  }
}
