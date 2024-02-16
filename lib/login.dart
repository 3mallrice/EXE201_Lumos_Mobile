import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:exe201_lumos_mobile/sign_up.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/api_services/authentication_service.dart';
import 'package:exe201_lumos_mobile/component/my_button.dart';
import 'package:exe201_lumos_mobile/component/my_textfield.dart';
import 'package:exe201_lumos_mobile/core/const/error_reponse.dart';
import 'package:exe201_lumos_mobile/core/helper/image_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

import 'component/alert_dialog.dart';
import 'core/helper/asset_helper.dart';
import 'representation/member/member_main_navbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String routeName = '/login_screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final CallAuthenticationApi authApi = CallAuthenticationApi();
  var logger = Logger();
  bool _passwordInVisible = true;

  void _showOKDialog(BuildContext context,
      {Text title = const Text("Tiêu đề"), message = const Text('Thông báo')}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(title: title, message: message);
      },
    );
  }

  // Hàm hiển thị hộp thoại thành công
  void onSuccess(String username) {
    //Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          LoginSuccessMessage.loginSuccess(username),
          style: GoogleFonts.almarai(
            color: ColorPalette.pinkBold,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorPalette.blue2,
      ),
    );

    Future.delayed(const Duration(seconds: 3));
    //delay 3s to navigate to main screen
    Navigator.of(context).pushNamed(MemberMain.routeName);
  }

  void _onEmptyField() {
    _showOKDialog(
      context,
      title: const Text(
        OnInvalidInputMessage.invalidInputTitle,
        style: TextStyle(color: ColorPalette.pinkBold),
      ),
      message: Text(OnInvalidInputMessage.emptyInput,
          style: GoogleFonts.almarai(color: ColorPalette.primaryText),
          overflow: TextOverflow.ellipsis,
          maxLines: 2),
    );
  }

  // Hàm hiển thị hộp thoại thất bại
  void _showFailDialog() {
    _showOKDialog(
      context,
      title: const Text(
        'Đăng nhập thất bại',
        style: TextStyle(color: ColorPalette.pinkBold),
      ),
      message: Text(LoginErrorMessage.wrongCredentials,
          style: GoogleFonts.almarai(color: ColorPalette.primaryText),
          overflow: TextOverflow.ellipsis,
          maxLines: 2),
    );
  }

  onPressedLogin() async {
    setState(() {
      isLoading =
          true; // Đặt isLoading thành true để hiển thị circular loading trên nút đăng nhập
    });

    String email = emailController.text.toLowerCase();
    String password = passwordController.text;

    try {
      if (email.isEmpty || password.isEmpty) {
        _onEmptyField();
        return;
      }

      LoginResponse response = await authApi.login(email, password);
      onSuccess(response.username);
    } catch (e) {
      logger.e('Login error: $e');
      _showFailDialog();
    } finally {
      setState(() {
        isLoading =
            false; // Đặt isLoading thành false sau khi kết thúc quá trình xử lý
      });
    }
  }

  onGoogleLogin() {
    //show notification show that on developing
    _showOKDialog(
      context,
      title: const Text(
        OnDevelopmentMessage.fearureOnDevelopmentTitle,
        style: TextStyle(color: ColorPalette.blueBold2),
      ),
      message: const Text(
        OnDevelopmentMessage.featureOnDevelopment,
        style: TextStyle(color: ColorPalette.primaryText),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  onTap() {
    onGoogleLogin();
  }

  Future<void> _loadImage() async {
    await precacheImage(const AssetImage(AssetHelper.imglogo1), context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: ColorPalette.white,
            body: Stack(children: [
              Positioned.fill(
                child: ImageHelper.loadFormAsset(
                  AssetHelper.imgSplashBg,
                  fit: BoxFit.fitWidth,
                ),
              ),
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
                          Transform.scale(
                            scale: 1.2,
                            child: Image.asset(AssetHelper.imglogo1),
                          ),
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
                          MyTextfield(
                            Controller: emailController,
                            labelText: 'Email',
                            hintText: 'a@gmail.com',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ColorPalette.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordInVisible = !_passwordInVisible;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                          MyButton(
                            onTap: onPressedLogin,
                            borderRadius: 66.5,
                            height: 55,
                            color: ColorPalette.pink,
                            widget: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      semanticsLabel: 'Đang đăng nhập',
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorPalette.pinkBold,
                                      ),
                                    ),
                                  )
                                : const Text(
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
                          MyButton(
                            onTap: onGoogleLogin,
                            borderRadius: 66.5,
                            height: 55,
                            color: ColorPalette.white,
                            borderColor: ColorPalette.primaryText,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Image.asset(
                                    AssetHelper.googleLogo,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Padding(
                                  padding: EdgeInsets.only(right: 16.0),
                                  child: Text(
                                    'Đăng nhập với Google',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        color: ColorPalette.primaryText),
                                  ),
                                ),
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
    );
  }
}
