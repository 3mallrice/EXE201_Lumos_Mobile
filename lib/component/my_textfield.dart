import 'package:flutter/material.dart';
import '../core/const/color_const.dart';

class MyTextfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  final TextEditingController Controller;
  final String hintText;
  final bool obscureText;

  const MyTextfield({
    super.key,
    // ignore: non_constant_identifier_names
    required this.Controller,
    required this.obscureText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: Controller, //require?
          obscureText:
              obscureText, //True or False, when type hide or not... (password)
          // maxLength: 30,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: ColorPalette.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: ColorPalette.pink),
              ),
              fillColor: const Color(0x50d9d9d9),
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: ColorPalette.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15)),
        ),
      ),
    );
  }
}
