import '../../api_model/authentication/login.dart';
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
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  //"Xong" button
  onPressedLogin() async {
    //Xong
  }

  UserDetails? userDetails;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void fetchUserData() async {
    userDetails = await loadAccount();
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
              controller: nameController,
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
              controller: emailController,
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
              controller: addressController,
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
              controller: phoneController,
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
