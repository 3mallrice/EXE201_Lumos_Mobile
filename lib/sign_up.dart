import 'dart:async';

import 'package:exe201_lumos_mobile/api_services/authentication_service.dart';
import 'package:exe201_lumos_mobile/core/const/back-end/validation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import 'component/alert_dialog.dart';
import 'core/const/back-end/error_reponse.dart';
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

  var log = Logger();

  OverlayEntry? _overlayEntry;

  // Hàm để hiển thị vòng loading
  void _showLoadingOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
              child: LoadingAnimationWidget.fourRotatingDots(
            color: ColorPalette.pinkBold,
            size: 80,
          )),
        ],
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  // Hàm để ẩn vòng loading
  void _hideLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  final CallAuthenticationApi callAuthenticationApi = CallAuthenticationApi();

  int isValidated(String email, String password, String confirmPassword,
      String phone, String name) {
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty ||
        name.isEmpty) {
      return 1;
    }
    if (!Validation.isValidEmail(email)) {
      return 2;
    }
    if (!Validation.isVietnamesePhoneNumber(phone)) {
      return 3;
    }
    if (!Validation.isValidPassword(password)) {
      return 4;
    }
    if (password != confirmPassword) {
      return 5;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadImage() async {
    await precacheImage(const AssetImage(AssetHelper.imglogo1), context);
  }

  void navigationReplacement(String? name) {
    if (name != null) {
      Navigator.of(context).pushReplacementNamed(name);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  onPressedLogin() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPassWordController.text;
      String phone = phoneController.text;
      String name = nameController.text;

      int validationStatus =
          isValidated(email, password, confirmPassword, phone, name);
      if (validationStatus == 0) {
        _showLoadingOverlay(context);

        // Chuyển đổi chữ cái đầu của tên thành viết hoa
        String? capitalizedFirstName = Validation.capitalizeFirstLetter(name);

        if (capitalizedFirstName == null) {
          _hideLoadingOverlay();
          _showErrorDialog(OnInvalidInputMessage.invalidName);
          return;
        }

        int statusCode = await callAuthenticationApi.register(
            email, name, password, confirmPassword, phone);
        if (statusCode == 200) {
          showSnackBar(
              OperationSuccessMessage.signUpSuccess(capitalizedFirstName));
          navigationReplacement(Login.routeName);
        } else if (statusCode == 409) {
          showSnackBar(OnInvalidInputMessage.alreadyExist);
        }
      } else {
        // Hiển thị thông báo lỗi cho trạng thái kiểm tra không hợp lệ
        _hideLoadingOverlay();
        switch (validationStatus) {
          case 1:
            _showErrorDialog(OnInvalidInputMessage.emptyInput);
            break;
          case 2:
            _showErrorDialog(OnInvalidInputMessage.invalidEmail);
            break;
          case 3:
            _showErrorDialog(OnInvalidInputMessage.invalidPhoneNumber);
            break;
          case 4:
            _showErrorDialog(OnInvalidInputMessage.invalidPassword);
            break;
          case 5:
            _showErrorDialog('Mật khẩu không khớp. Vui lòng kiểm tra lại!');
            break;
          default:
            _showErrorDialog(OperationErrorMessage.systemError);
            break;
        }
      }
    } catch (e) {
      // Xử lý bất kỳ ngoại lệ nào ở đây
      log.e('Lỗi xảy ra: $e');
      _showErrorDialog(OperationErrorMessage.systemError);
    } finally {
      _hideLoadingOverlay();
    }
  }

  //show dialog show error when isValidate return false
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: Text(
          OnInvalidInputMessage.invalidInputTitle,
          style: GoogleFonts.roboto(
            color: ColorPalette.blueBold2,
            fontWeight: FontWeight.bold,
          ),
        ),
        message: Text(message),
        confirmText: 'OK',
      ),
    );
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
                      physics: const BouncingScrollPhysics(),
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

                            const Text(
                              'Đăng ký',
                              style: TextStyle(
                                color: ColorPalette.blueBold2,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //name textfield
                            MyTextfield(
                              controller: nameController,
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
                              keyboardType: TextInputType.emailAddress,
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
                              maxLength: 10,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              keyboardType: TextInputType.phone,
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
                                  keyboardType: TextInputType.visiblePassword,
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
                                  keyboardType: TextInputType.visiblePassword,
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

                            Tooltip(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              richMessage: TextSpan(
                                text: OnInvalidInputMessage.signUpGuide,
                                style: GoogleFonts.roboto(
                                    color: ColorPalette.blueBold2,
                                    fontSize: 14),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                backgroundBlendMode: BlendMode.srcOver,
                                color: ColorPalette.bluelight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              waitDuration: const Duration(milliseconds: 600),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Hướng dẫn đăng ký ",
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.blueBold2,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.info,
                                    color: ColorPalette.blueBold2,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: double.infinity,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Bằng việc đăng ký tài khoản tại Lumos, tôi đã đọc và đồng ý với các ',
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.blueBold2
                                            .withOpacity(0.65),
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'điều khoản và chính sách',
                                      onEnter: (event) {
                                        //launch https://lumos.com/term
                                      },
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.pinkBold
                                            .withOpacity(0.65),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' của Lumos.',
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.blueBold2
                                            .withOpacity(0.65),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            //sign-in button
                            SignUpButton(
                              onPressed: onPressedLogin,
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
                                        .pushReplacementNamed(Login.routeName);
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

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onTap: onPressed,
      borderRadius: 66.5,
      height: 55,
      color: ColorPalette.pink,
      widget: const Text(
        'Hoàn thành',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorPalette.white),
      ),
    );
  }
}
