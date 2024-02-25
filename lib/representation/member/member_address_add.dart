import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';

import '../../api_model/authentication/login.dart';
import '../../api_services/customer_service.dart';
import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';

class AddressAdd extends StatefulWidget {
  const AddressAdd({super.key});

  static String routeName = '/address_addnew';

  @override
  State<AddressAdd> createState() => _AddressAddState();
}

class _AddressAddState extends State<AddressAdd> {
  List<String> displayName = ['Nhà riêng', 'Công ty', 'Khác'];
  final TextEditingController _addressController = TextEditingController();

  CallCustomerApi api = CallCustomerApi();
  var log = Logger();

  bool isEmptyList = true;

  UserDetails? userDetails;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void _fetchUserData() async {
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.of(context).pushReplacementNamed(Login.routeName);
        },
      );
    } else {
      //_saveData();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: "Tạo mới địa chỉ",
        leading: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Builder(builder: (context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextButton(
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPalette.pink,
                          ),
                          padding: const EdgeInsets.only(
                              right: 18, left: 16.5, top: 16.5, bottom: 18),
                          child: const Icon(
                            FontAwesomeIcons.mapLocationDot,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onPressed: () async {
                          LocationData? locationData =
                              await LocationSearch.show(
                            context: context,
                            lightAdress: true,
                            mode: Mode.overlay,
                            countryCodes: ['VN'],
                            language: 'vi',
                            searchBarHintText: 'Nhập địa chỉ',
                            searchBarHintColor: ColorPalette.blueBold2,
                            historyMaxLength: 5,
                            searchBarBackgroundColor:
                                ColorPalette.secondaryWhite,
                            loadingWidget: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.toString()),
                                ),
                              );
                            },
                            currentPositionButtonText: 'Vị trí hiện tại',
                            searchBarTextColor: ColorPalette.blueBold2,
                          );

                          setState(() {
                            _addressController.text =
                                locationData?.address ?? '';
                          });
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên gợi nhớ',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    CustomDropdown<String>(
                      closedHeaderPadding: const EdgeInsets.all(20),
                      hintText: 'Chọn tên gợi nhớ',
                      items: displayName,
                      initialItem: displayName[0],
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: CustomDropdownDecoration(
                        headerStyle: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        hintStyle: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                        ),
                        closedFillColor: ColorPalette.secondaryWhite,
                        closedBorderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        closedBorder: const Border(
                          top:
                              BorderSide(color: ColorPalette.grey2, width: 1.0),
                          left:
                              BorderSide(color: ColorPalette.grey2, width: 1.0),
                          right:
                              BorderSide(color: ColorPalette.grey2, width: 1.0),
                          bottom:
                              BorderSide(color: ColorPalette.grey2, width: 1.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    TextField(
                      controller: _addressController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Địa chỉ của bạn là...',
                        hintStyle: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                        ),
                        filled: true,
                        fillColor: ColorPalette.secondaryWhite,
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.grey2, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.grey2, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      style: GoogleFonts.roboto(
                        color: ColorPalette.blueBold2.withOpacity(0.65),
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
