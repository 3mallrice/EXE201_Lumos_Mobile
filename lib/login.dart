import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

import 'component/my_button.dart';
import 'component/my_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String routeName = '/login_screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordInVisible = true;

  @override
  void initState() {
    super.initState();
  }

  onPressedLogin() async {
    // Lấy email và password từ text field
    String email = emailController.text;
    String password = passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),

                //logo
                SizedBox(
                  width: 300,
                  height: 230,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Image.asset(AssetHelper.imgLogo)),
                ),

                //welcome back, you've been missed!
                const Text(
                  'Log in',
                  style: TextStyle(
                    color: ColorPalette.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //username textfield
                MyTextfield(
                  Controller: emailController,
                  labelText: 'Email',
                  hintText: 'Your email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(
                  height: 20,
                ),

                //password textfield
                MyTextfield(
                  Controller: passwordController,
                  obscureText: _passwordInVisible,
                  labelText: 'Password',
                  hintText: 'Your password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordInVisible
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons
                              .eyeSlash, //change icon based on boolean value
                      color: ColorPalette.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordInVisible =
                            !_passwordInVisible; //change boolean value
                      });
                    },
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //forgot password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(color: ColorPalette.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //sign-in button
                // MyButton(
                //   onTap: onPressedLogin,
                //   text: 'Login',
                //   color: ColorPalette.white,
                //   textColor: ColorPalette.primaryText,
                // ),

                //Google + Facebook buttons

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
