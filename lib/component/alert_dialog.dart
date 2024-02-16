import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/const/color_const.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget title;
  final Widget message;
  final Function? onConfirm;
  final String? confirmText;
  final Widget? action;

  const CustomAlertDialog(
      {super.key,
      this.title = const Text("Tiêu đề"),
      this.message = const Text('Thông báo'),
      this.confirmText,
      this.onConfirm,
      this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      title: title,
      content: message,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: [
        if (action != null) action!,
        TextButton(
          onPressed: onConfirm != null
              ? () => onConfirm!()
              : () => Navigator.of(context).pop(),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          child: Text(
            confirmText ?? 'OK',
            style: GoogleFonts.almarai(
              color: ColorPalette.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}
