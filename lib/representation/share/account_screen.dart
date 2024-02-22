import '../../api_model/authentication/login.dart';
import '../../core/const/back-end/error_reponse.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import '../member/medical_report.dart';
import 'package:flutter/material.dart';
import '../../component/app_bar.dart';
import '../../component/my_button.dart';
import '../../component/my_button_list.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/const/front-end/lumos_icons.dart';
import '../../core/helper/asset_helper.dart';
import 'about_lumos.dart';
import 'bill_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import '../../api_services/authentication_service.dart';
import '../../component/alert_dialog.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  static String routeName = '/account_screen';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final CallAuthenticationApi _api = CallAuthenticationApi();
  var log = Logger();
  Future<UserDetails>? userDetails;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void fetchUserData() async {
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
    userDetails = loadAccount();
    super.initState();
    fetchUserData();
  }

  backToLoginPage() {
    Navigator.of(context).pushNamed(Login.routeName);
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: Text(
            OnSignOutMessage.signOutTitle,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: ColorPalette.blueBold2,
            ),
          ),
          message: Text(
            OnSignOutMessage.signOutMessage,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: ColorPalette.primaryText,
            ),
          ),
          onConfirm: () {
            Navigator.of(context).pop();
            onLogout();
          },
          confirmText: OnSignOutMessage.signOutConfirm,
          action: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              OnSignOutMessage.signOutCancel,
              style: GoogleFonts.roboto(
                color: ColorPalette.primaryText,
              ),
            ),
          ),
        );
      },
    );
  }

  onLogout() async {
    try {
      await _api.signOut();
      backToLoginPage();
    } catch (e) {
      log.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (userDetails == null) {
    //   return Scaffold(
    //     body: Center(
    //       child: LoadingAnimationWidget.fourRotatingDots(
    //         color: ColorPalette.pinkBold,
    //         size: 80,
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
        appBar: const AppBarCom(
          leading: false,
          appBarText: 'Tài khoản',
        ),
        body: FutureBuilder(
          future: userDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 75),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
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
                          const SizedBox(height: 10),
                          _buildAccountInfo(
                              user), // Extracted account info section
                          const SizedBox(height: 10),
                          _buildButtonList(
                            text: 'Hóa đơn',
                            leftIcon: Icons.credit_card,
                            rightIcon: Icons.arrow_forward_ios,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(BillScreen.routeName);
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildButtonList(
                            text: 'Đặt chỗ',
                            leftIcon: Icons.calendar_month_outlined,
                            rightIcon: Icons.arrow_forward_ios,
                            onPressed: () {
                              // Navigate to reservation screen
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildButtonList(
                            text: 'Danh sách bệnh nhân',
                            leftIcon: Icons.paste_sharp,
                            rightIcon: Icons.arrow_forward_ios,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(MedicalReportPage.routeName);
                            },
                          ),
                          const SizedBox(height: 10),
                          _buildButtonList(
                            text: 'Về Lumos',
                            leftIcon: LumosIcons.hearticon,
                            rightIcon: Icons.arrow_forward_ios,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AboutUs.routeName);
                            },
                          ),
                          const SizedBox(height: 30),
                          MyButton(
                            onTap: _showLogoutConfirmationDialog,
                            color: ColorPalette.blue,
                            borderRadius: 66.50,
                            widget: const Text(
                              'Đăng xuất',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorPalette.secondaryWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          const SizedBox(
                            height: 30,
                            child: Center(
                              child: Text(
                                '© All copyright of Lumos',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.blueBold2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget _buildAccountInfo(UserDetails user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          user.username.toString(),
          style: const TextStyle(
            color: ColorPalette.blueBold2,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () {
            // Navigator.of(context).pushNamed(UpdateAccount.routeName);
          },
          icon: const Icon(
            LumosIcons.edit_2icon,
            color: ColorPalette.blueBold2,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonList({
    required String text,
    required IconData leftIcon,
    required IconData rightIcon,
    required VoidCallback onPressed,
  }) {
    return MyButtonList(
      text: text,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      onPressed: onPressed,
    );
  }
}
