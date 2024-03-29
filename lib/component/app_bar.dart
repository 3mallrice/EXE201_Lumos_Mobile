import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/const/front-end/color_const.dart';

class AppBarCom extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarText;
  final bool leading;
  final Widget? leftIcon;
  final String? routeName;
  final Color? backgroundColor;
  final Color? textColor;
  final List<Widget>? action;

  const AppBarCom({
    super.key,
    this.appBarText,
    required this.leading,
    this.leftIcon,
    this.backgroundColor,
    this.textColor,
    this.action,
    this.routeName,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: leading,
        leading: leading
            ? leftIcon ??
                IconButton(
                  onPressed: () {
                    routeName == null
                        ? Navigator.of(context).pop()
                        : Navigator.of(context)
                            .pushReplacementNamed(routeName!);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                  ),
                )
            : null,
        iconTheme: const IconThemeData(color: ColorPalette.secondaryWhite),
        backgroundColor: backgroundColor ?? ColorPalette.blue,
        title: Text(appBarText ?? ""),
        titleTextStyle: GoogleFonts.roboto(
          textStyle: TextStyle(
              color: textColor ?? ColorPalette.blueBold2,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        actions: action,
      ),
    );
  }
}
