import 'package:exe201_lumos_mobile/api_services/authentication_service.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'component/my_button.dart';
import 'component/my_textfield.dart';
import 'core/const/front-end/color_const.dart';
import 'core/helper/asset_helper.dart';
import 'core/helper/image_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static String routeName = '/sign_up_screen';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassWordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  bool _passwordInVisible = true;
  bool _confirmPasswordInVisible = true;

  final CallAuthenticationApi callAuthenticationApi = CallAuthenticationApi();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadImage() async {
    await precacheImage(const AssetImage(AssetHelper.imglogo1), context);
  }

  onPressedLogin() async {
    // Lấy email và password từ text field
    // ignore: unused_local_variable
    String email = emailController.text;
    // ignore: unused_local_variable
    String password = passwordController.text;

    Navigator.of(context).pushNamed(Login.routeName);
  }

  //forget password
  Function()? onTap() {
    return null;
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
                            //logo
                            SizedBox(
                              height: 150,
                              width: 250,
                              child: Image.asset(
                                AssetHelper.imglogo1,
                                fit: BoxFit.fitHeight,
                              ),
                            ),

                            //welcome back, you've been missed!
                            const Text(
                              'Đăng ký',
                              style: TextStyle(
                                color: ColorPalette.blueBold2,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            //name textfield
                            MyTextfield(
                              controller: emailController,
                              labelText: 'Họ và Tên',
                              hintText: 'Nguyễn Văn A',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            //email textfield
                            MyTextfield(
                              controller: emailController,
                              labelText: 'Email',
                              hintText: 'a@gmail.com',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            //phone textfield
                            MyTextfield(
                              controller: phoneController,
                              labelText: 'Số điện thoại',
                              hintText: '0912345678',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            //password textfield
                            StatefulBuilder(
                              builder: (context, setState) {
                                return MyTextfield(
                                  controller: passwordController,
                                  obscureText: _passwordInVisible,
                                  labelText: 'Mật khẩu',
                                  hintText: 'Nhập mật khẩu của bạn...',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  textInputAction: TextInputAction.next,
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
                              height: 15,
                            ),

                            StatefulBuilder(
                              builder: (context, setState) {
                                return MyTextfield(
                                  controller: confirmPassWordController,
                                  obscureText: _confirmPasswordInVisible,
                                  labelText: 'Nhập lại mật khẩu',
                                  hintText: 'Nhập lại mật khẩu...!',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  textInputAction: TextInputAction.done,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confirmPasswordInVisible
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      //change icon based on boolean value
                                      color: ColorPalette.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordInVisible =
                                            !_confirmPasswordInVisible; //change boolean value
                                      });
                                    },
                                  ),
                                );
                              },
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(
                              "Bằng việc đồng ý tạo tài khoản, bạn đã đồng ý với các điều khoản và chính sách của chúng tôi.",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2.withOpacity(0.42),
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            //sign-in button
                            MyButton(
                              onTap: onPressedLogin,
                              borderRadius: 66.5,
                              height: 55,
                              color: ColorPalette.pink,
                              widget: const Text(
                                'Hoàn Thành',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: ColorPalette.white),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Đã có tài khoản? ",
                                  style: TextStyle(
                                      color: ColorPalette.blueBold2
                                          .withOpacity(0.65),
                                      fontSize: 16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(Login.routeName);
                                  },
                                  child: const Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.blueBold2,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
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
