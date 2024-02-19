import 'package:flutter/material.dart';
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
  final FloatingLabelBehavior? floatingLabelBehavior;

  const MyTextfield(
      {super.key,
      required this.controller,
      this.validator,
      required this.obscureText,
      required this.labelText,
      this.bgColor,
      this.textColor,
      this.hintText,
      this.suffixIcon,
      this.textInputAction,
      this.floatingLabelBehavior});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: SizedBox(
        height: 70,
        child: TextFormField(
          validator: validator,
          style: TextStyle(
            color: textColor ?? ColorPalette.blueBold2.withOpacity(0.65),
            fontFamily: 'Raleway',
          ),
          maxLines: 1,
          controller: controller,
          //require?
          obscureText: obscureText,
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
            labelText: labelText,
            labelStyle: const TextStyle(
              color: ColorPalette.blueBold,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 18,
            ),
            floatingLabelBehavior: floatingLabelBehavior,
            fillColor: bgColor ?? ColorPalette.white,
            filled: true,
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: ColorPalette.grey,
              fontWeight: FontWeight.normal,
              fontFamily: 'Raleway',
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
