import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/const/front-end/color_const.dart';

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
      elevation: 2,
      actions: [
        (action != null)
            ? action!
            : TextButton(
                onPressed: onConfirm != null
                    ? () => onConfirm!()
                    : () => Navigator.of(context).pop(),
                style: ButtonStyle(
                  enableFeedback: true,
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => ColorPalette.pink.withOpacity(0.2)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(1.0),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(ColorPalette.pinkBold),
                ),
                child: Text(
                  confirmText ?? 'OK',
                  style: GoogleFonts.roboto(
                    color: ColorPalette.pinkBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ],
    );
  }
}
