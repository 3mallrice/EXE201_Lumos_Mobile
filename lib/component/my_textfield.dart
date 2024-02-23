import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/const/front-end/color_const.dart';

class MyTextfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final Color? bgColor;
  final Color? textColor;
  final TextInputType? keyboardType;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final int? maxLength;

  const MyTextfield({
    super.key,
    required this.controller,
    this.validator,
    required this.obscureText,
    required this.labelText,
    this.bgColor,
    this.textColor,
    this.hintText,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.floatingLabelBehavior,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: SizedBox(
        height: 70,
        child: TextFormField(
          minLines: 1,
          validator: validator,
          style: GoogleFonts.roboto(
            color: textColor ?? ColorPalette.blueBold2.withOpacity(0.65),
          ),
          maxLines: 1,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          //require?
          obscureText: obscureText,
          maxLength: maxLength,
          //True or False, when type hide or not... (password)
          // maxLength: 30,
          textInputAction: textInputAction,

          decoration: InputDecoration(
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: ColorPalette.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: ColorPalette.pink),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorPalette.red),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorPalette.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            errorMaxLines: 1,
            labelText: labelText,
            labelStyle: GoogleFonts.roboto(
              color: ColorPalette.blueBold,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            floatingLabelBehavior:
                floatingLabelBehavior ?? FloatingLabelBehavior.auto,
            fillColor: bgColor ?? ColorPalette.white,
            filled: true,
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: ColorPalette.grey,
              fontWeight: FontWeight.normal,
              fontFamily: 'roboto',
              fontSize: 15,
            ),
            suffixIcon: suffixIcon,
          ),
          cursorColor: ColorPalette.primaryText, //màu con trỏ
        ),
      ),
    );
  }
}
