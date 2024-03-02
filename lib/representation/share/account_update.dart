import '../../core/const/back-end/error_reponse.dart';
import '../member/member_main_navbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_model/authentication/login.dart';
import '../../component/alert_dialog.dart';
import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/asset_helper.dart';
import 'package:flutter/material.dart';

import '../../component/my_button.dart';
import '../../component/my_textfield.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';

class UpdateAccount extends StatefulWidget {
  const UpdateAccount({super.key});

  static String routeName = '/update_account';

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  //text controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  //"Xong" button
  onPressedUpdate() {
    //show custom alert dialog to tell developing feature
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: Text(OnDevelopmentMessage.fearureOnDevelopmentTitle,
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorPalette.blueBold2,
              )),
          message: Text(
            OnDevelopmentMessage.featureOnDevelopment,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: ColorPalette.blueBold2,
            ),
          ),
          action: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MemberMain.routeName);
            },
            child: Text(
              "Về Màn hình chính",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorPalette.pinkBold,
              ),
            ),
          ),
        );
      },
    );
  }

  UserDetails? userDetails;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void fetchUserData() async {
    userDetails = await loadAccount();
    nameController.text = userDetails!.username;
    emailController.text = userDetails!.email;
    if (userDetails == null) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.of(context).pushReplacementNamed(Login.routeName);
        },
      );
    } else {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Tài khoản',
        leading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AssetHelper.accountImg),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.pink,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: onPressedUpdate,
                          color: ColorPalette.secondaryWhite,
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            weight: 50,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MyTextfield(
              controller: nameController,
              labelText: 'Họ và tên',
              hintText: 'Tên của bạn',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              obscureText: false,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextfield(
              controller: emailController,
              labelText: 'Email',
              hintText: 'Email',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              obscureText: false,
              textInputAction: TextInputAction.next,
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            // MyTextfield(
            //   controller: addressController,
            //   labelText: 'Address',
            //   hintText: 'Your address',
            //   floatingLabelBehavior: FloatingLabelBehavior.always,
            //   obscureText: false,
            //   textInputAction: TextInputAction.next,
            // ),
            const SizedBox(
              height: 30,
            ),
            MyTextfield(
              controller: phoneController,
              labelText: 'Điện thoại',
              hintText: 'Điện thoại của bạn',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              obscureText: false,
              textInputAction: TextInputAction.done,
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 45,
            ),
            MyButton(
              onTap: onPressedUpdate,
              borderRadius: 66.5,
              height: 55,
              color: ColorPalette.pink,
              widget: const Text(
                'Xong',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ColorPalette.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
