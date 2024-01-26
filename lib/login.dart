import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/representation/member/member_main_navbar.dart';
import 'package:exe201_lumos_mobile/representation/share/account_screen.dart';
import 'package:exe201_lumos_mobile/representation/share/account_update.dart';
import 'package:exe201_lumos_mobile/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'component/my_button.dart';
import 'component/my_textfield.dart';
import 'core/helper/image_helper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String routeName = '/login_screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordInVisible = true;

  @override
  void initState() {
    super.initState();
  }

  onPressedLogin() async {
    // Lấy email và password từ text field
    String email = emailController.text;
    String password = passwordController.text;

    //Navigator.of(context).pushNamed(MemberHome.routeName);
    Navigator.of(context).pushNamed(MemberMain.routName);
  }

  //forget password
  Function()? onTap() {
    return null;
  }

  Future<void> _loadImage() async {
    await precacheImage(const AssetImage(AssetHelper.imglogo1), context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: FutureBuilder(
        future: _loadImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: ColorPalette.white,
              body: Stack(children: [
                Positioned.fill(
                    child: ImageHelper.loadFormAsset(AssetHelper.imgSplashBg,
                        fit: BoxFit.fitWidth)),
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),

                            //logo
                            Transform.scale(
                              scale: 1.2,
                              child: Image.asset(AssetHelper.imglogo1),
                            ),

                            //welcome back, you've been missed!
                            const Text(
                              'Đăng nhập',
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
                              hintText: 'abc@gmail.com',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //password textfield
                            StatefulBuilder(
                              builder: (context, setState) {
                                return MyTextfield(
                                  Controller: passwordController,
                                  obscureText: _passwordInVisible,
                                  labelText: 'Mật khẩu',
                                  hintText: 'Mật khẩu của bạn...',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  textInputAction: TextInputAction.done,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordInVisible
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      //change icon based on boolean value
                                      color: ColorPalette.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordInVisible =
                                            !_passwordInVisible; //change boolean value
                                      });
                                    },
                                  ),
                                );
                              },
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //forgot password
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: onTap,
                                    child: const Text(
                                      'Quên mật khẩu?',
                                      style: TextStyle(
                                          color: ColorPalette.pink,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //sign-in button
                            MyButton(
                              onTap: onPressedLogin,
                              borderRadius: 66.5,
                              height: 55,
                              text: 'Login',
                              color: ColorPalette.pink,
                              widget: const Text(
                                'Đăng nhập',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: ColorPalette.white),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //Google + Facebook buttons
                            MyButton(
                              onTap: onPressedLogin,
                              borderRadius: 66.5,
                              height: 55,
                              text: 'Login',
                              color: ColorPalette.white,
                              borderColor: ColorPalette.primaryText,
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon Google
                                  // Thêm padding trái cho icon
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Image.asset(
                                        AssetHelper.googleLogo,
                                        fit: BoxFit.fill,
                                      )),

                                  // Thêm SizedBox giữa icon và text
                                  const SizedBox(width: 16),

                                  // Thêm padding phải cho text
                                  const Padding(
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        'Đăng nhập với Google',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            color: ColorPalette.primaryText),
                                      )),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 100,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Chưa có tài khoản? ",
                                  style: TextStyle(
                                      color: ColorPalette.blueBold2
                                          .withOpacity(0.65),
                                      fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(context);
                                    Navigator.of(context)
                                        .pushNamed(SignUp.routeName);
                                  },
                                  child: const Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.blueBold2,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 200,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
