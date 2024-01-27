import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:exe201_lumos_mobile/core/helper/asset_helper.dart';
import 'package:exe201_lumos_mobile/representation/share/account_screen.dart';
import 'package:flutter/material.dart';

import '../../component/my_button.dart';
import '../../component/my_textfield.dart';

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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  //"Xong" button
  onPressedLogin() async {
    //Xong
  }

  @override
  void initState() {
    super.initState();
    // Assign default values to text controllers
    nameController.text = 'Default Name';
    emailController.text = 'Default Email';
    addressController.text = 'Default Address';
    phoneController.text = 'Default Phone';
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
                          onPressed: () {},
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
              Controller: nameController,
              labelText: 'Name',
              hintText: 'Your name',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              obscureText: false,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextfield(
              Controller: emailController,
              labelText: 'Email',
              hintText: 'Your email',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              obscureText: false,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextfield(
              Controller: addressController,
              labelText: 'Address',
              hintText: 'Your address',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              obscureText: false,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextfield(
              Controller: phoneController,
              labelText: 'Phone',
              hintText: 'Your phone',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              obscureText: false,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 45,
            ),
            MyButton(
              onTap: onPressedLogin,
              borderRadius: 66.5,
              height: 55,
              text: 'Xong',
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
