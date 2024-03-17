import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/address.dart';
import '../../api_services/customer_service.dart';
import '../../component/alert_dialog.dart';
import '../../core/const/back-end/error_reponse.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'member_address_add.dart';
import 'package:logger/logger.dart';

import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';

class MemberAddress extends StatefulWidget {
  final String? onAddressSelected;

  const MemberAddress({super.key, this.onAddressSelected});

  static String routeName = '/member_address';

  @override
  State<MemberAddress> createState() => _MemberAddressState();
}

class _MemberAddressState extends State<MemberAddress> {
  CallCustomerApi api = CallCustomerApi();
  var log = Logger();

  List<Address> _address = [];

  UserDetails? userDetails;

  bool isEmptyList = true;
  bool isLoaded = false;

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
      _fetchAddress();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  void _fetchAddress() async {
    try {
      if (userDetails != null && userDetails!.id != null) {
        List<Address>? address = await api.getCustomerAddress(userDetails!.id!);
        setState(() {
          _address = address;
          isEmptyList = _address.isEmpty;
          isLoaded = true;
        });
      } else {
        setState(() {
          log.e("User details or user id is null.");
          _address = [];
          isEmptyList = true;
          isLoaded = true;
        });
      }
    } catch (e) {
      setState(() {
        log.e("Error when fetching address: $e");
        _address = [];
        isEmptyList = true;
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        leading: true,
        appBarText: 'Danh sách địa chỉ',
      ),
      body: !isLoaded
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            )
          : isEmptyList
              ? const Center(
                  child: Text(
                    'Không có địa chỉ nào, hãy thêm địa chỉ!',
                    style: TextStyle(
                      color: ColorPalette.blue2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: ColorPalette.blue2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: ListView.builder(
                    clipBehavior: Clip.antiAlias,
                    shrinkWrap: true,
                    itemCount: _address.length,
                    itemBuilder: (context, index) {
                      final item = _address[index];
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.displayName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.blueBold2,
                                          fontSize: 16,
                                          fontFamily: 'roboto',
                                        ),
                                      ),
                                      Text(
                                        item.address,
                                        style: const TextStyle(
                                          fontFamily: 'roboto',
                                          color: ColorPalette.bluelight2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => onDevelopmentFeature(),
                                    child: IconButton(
                                      onPressed: () => onDevelopmentFeature(),
                                      icon: const Icon(
                                          Icons.edit_location_alt_rounded),
                                      color: ColorPalette.blueBold2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index < _address.length - 1 &&
                              _address.length > 1)
                            const Divider(
                              thickness: 2,
                              height: 2,
                              color: ColorPalette.white,
                            ),
                        ],
                      );
                    },
                  ),
                ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddressAdd.routeName);
            log.i('Button pressed');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalette.pink,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: ColorPalette.white,
          ),
        ),
      ),
    );
  }

  void onDevelopmentFeature() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: Text(OnDevelopmentMessage.fearureOnDevelopmentTitle,
              style: GoogleFonts.roboto(
                color: ColorPalette.blueBold2,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          message: Text(
            OnDevelopmentMessage.featureOnDevelopment,
            style: GoogleFonts.roboto(
              color: ColorPalette.blueBold2,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          confirmText: "OK",
          onConfirm: () {
            setState(() {});
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
