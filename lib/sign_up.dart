import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/member/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'component/my_button.dart';
import 'component/my_textfield.dart';
import 'core/const/color_const.dart';
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
  bool _passwordInVisible = true;
  bool _confirmPasswordInVisible = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadImage() async {
    await precacheImage(const AssetImage(AssetHelper.imglogo1), context);
  }

  onPressedLogin() async {
    // Lấy email và password từ text field
    String email = emailController.text;
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
                            'Sign up',
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
                            Controller: emailController,
                            labelText: 'Name',
                            hintText: 'Your Name',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //email textfield
                          MyTextfield(
                            Controller: emailController,
                            labelText: 'Email',
                            hintText: 'Your Email',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //phone textfield
                          MyTextfield(
                            Controller: emailController,
                            labelText: 'Phone',
                            hintText: 'Your Phone',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //Address textfield
                          MyTextfield(
                            Controller: emailController,
                            labelText: 'Address',
                            hintText: 'Your Address',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                labelText: 'Password',
                                hintText: 'Your password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                textInputAction: TextInputAction.next,
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
                              );
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          StatefulBuilder(
                            builder: (context, setState) {
                              return MyTextfield(
                                Controller: passwordController,
                                obscureText: _confirmPasswordInVisible,
                                labelText: 'Password',
                                hintText: 'Your password',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                textInputAction: TextInputAction.done,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _confirmPasswordInVisible
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons
                                            .eyeSlash, //change icon based on boolean value
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
                            height: 30,
                          ),

                          //sign-in button
                          MyButton(
                            onTap: onPressedLogin,
                            borderRadius: 66.5,
                            height: 55,
                            text: 'Sign up',
                            color: ColorPalette.pink,
                            widget: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: ColorPalette.white),
                            ),
                          ),

                          const SizedBox(
                            height: 50,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
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
                                  'Sign in',
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
