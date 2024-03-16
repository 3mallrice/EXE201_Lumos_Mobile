import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

import 'api_model/authentication/login.dart';
import 'api_services/authentication_service.dart';
import 'component/alert_dialog.dart';
import 'component/my_button.dart';
import 'component/my_textfield.dart';
import 'core/const/back-end/error_reponse.dart';
import 'core/const/back-end/role.dart';
import 'core/const/front-end/color_const.dart';
import 'core/helper/asset_helper.dart';
import 'core/helper/image_helper.dart';
import 'core/helper/local_storage_helper.dart';
import 'representation/member/member_main_navbar.dart';
import 'sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String routeName = '/login_screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with RestorationMixin {
  final RestorableTextEditingController emailController =
      RestorableTextEditingController();
  final RestorableTextEditingController passwordController =
      RestorableTextEditingController();
  final CallAuthenticationApi authApi = CallAuthenticationApi();
  var logger = Logger();

  bool _passwordInVisible = true;

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

  String? Function(String?)? emailValidator = (value) {
    if (value == null || value.isEmpty) {
      return OnInvalidInputMessage.emptyInput;
    }

    if (!value.contains('@') || !value.contains('.com')) {
      return OnInvalidInputMessage.invalidEmail;
    }
    return null;
  };

  String? Function(String?)? passwordValidator = (value) {
    if (value == null || value.isEmpty) {
      return OnInvalidInputMessage.emptyInput;
    }

    if (value.length < 8 ||
        !value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[a-z]')) ||
        !value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return OnInvalidInputMessage.invalidPassword;
    }
    return null;
  };

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
    //Snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          LoginSuccessMessage.loginSuccess(username),
          style: GoogleFonts.roboto(
            color: ColorPalette.pinkBold,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorPalette.blue2,
      ),
    );

    Future.delayed(const Duration(seconds: 2));

    // Navigator.of(context).pushReplacementNamed(MemberMain.routeName);
    Navigator.restorablePushReplacementNamed(context, MemberMain.routeName);
  }

  void _onEmptyField() {
    _showOKDialog(
      context,
      title: const Text(
        OnInvalidInputMessage.invalidInputTitle,
        style: TextStyle(color: ColorPalette.pinkBold),
      ),
      message: Text(OnInvalidInputMessage.emptyInput,
          style: GoogleFonts.roboto(color: ColorPalette.primaryText),
          overflow: TextOverflow.ellipsis,
          maxLines: 2),
    );
  }

  // Hàm hiển thị hộp thoại thất bại
  void _showFailDialog() {
    // //show keyboard when click login

    _showOKDialog(
      context,
      title: const Text(
        'Đăng nhập thất bại',
        style: TextStyle(color: ColorPalette.pinkBold),
      ),
      message: Text(LoginErrorMessage.wrongCredentials,
          style: GoogleFonts.roboto(color: ColorPalette.primaryText),
          overflow: TextOverflow.ellipsis,
          maxLines: 2),
    );
  }

  onPressedLogin() async {
    String email = emailController.value.text.toLowerCase().trim();
    String password = passwordController.value.text.trim();

    try {
      if (email.isEmpty || password.isEmpty) {
        _onEmptyField();
        return;
      }

      _showLoadingOverlay(context);
      UserDetails userDetails = await authApi.login(email, password);

      // UserDetails userDetails = response.userDetails;
      if (userDetails.role == Role.customer) {
        //save userDetail in local storage
        await LoginAccount.saveLoginAccount(userDetails);

        logger.i('Login success: ${userDetails.fullname}');
        onSuccess(userDetails.fullname);
      } else {
        throw Exception('Invalid role');
      }
    } catch (e) {
      logger.e('Login error: $e');
      _showFailDialog();
    } finally {
      // Ẩn vòng loading khi quá trình đăng nhập hoàn thành
      _hideLoadingOverlay();
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

  Future<void> _load() async {
    await precacheImage(const AssetImage(AssetHelper.imglogo1), context);
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return PopScope(
            canPop: false,
            child: Scaffold(
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
                              validator: emailValidator,
                              controller: emailController.value,
                              labelText: 'Email',
                              hintText: 'a@gmail.com',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return MyTextfield(
                                  validator: passwordValidator,
                                  controller: passwordController.value,
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
                                        _passwordInVisible =
                                            !_passwordInVisible;
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
                            MyButton(
                              onTap: onGoogleLogin,
                              borderRadius: 66.5,
                              height: 55,
                              // width: 300,
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
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        'Đăng nhập với Google',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: ColorPalette.primaryText),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        locale: Locale('vi'),
                                        textDirection: TextDirection.ltr,
                                        textWidthBasis:
                                            TextWidthBasis.longestLine,
                                        maxLines: 1,
                                      ),
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
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => Login.routeName;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
    registerForRestoration(emailController, "login_email");
    registerForRestoration(passwordController, "login_password");
  }
}

class LoginWithGoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginWithGoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onTap: () {},
      borderRadius: 66.5,
      height: 55,
      width: 300,
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
    );
  }
}
