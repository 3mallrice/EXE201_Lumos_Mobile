import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:exe201_lumos_mobile/api_model/customer/address.dart';
import 'package:exe201_lumos_mobile/api_services/customer_service.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:exe201_lumos_mobile/login.dart';
import 'package:exe201_lumos_mobile/representation/member/member_booking.dart';
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
  bool _isEmptyList = true;

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
      _fetchAddress();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchAddress() async {
    try {
      if (userDetails != null && userDetails!.id != null) {
        List<Address>? address = await api.getCustomerAddress(userDetails!.id!);
        setState(() {
          _address = address;
          _isEmptyList = _address.isEmpty;
        });
      } else {
        setState(() {
          log.e("User details or user id is null.");
          _address = [];
          _isEmptyList = true;
        });
      }
    } catch (e) {
      setState(() {
        log.e("Error when fetching address: $e");
        _address = [];
        _isEmptyList = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        leading: true,
        appBarText: 'Chọn địa chỉ đặt lịch',
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        child: InkWell(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingPage(
                                  address: item.address1,
                                ),
                              ),
                            ),
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.blueBold2,
                                  fontSize: 16,
                                  fontFamily: 'almarai',
                                ),
                              ),
                              Text(
                                item.address1,
                                style: const TextStyle(
                                  fontFamily: 'almarai',
                                  color: ColorPalette.bluelight2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Sửa',
                            style: TextStyle(
                              color: ColorPalette.pink,
                              fontSize: 16,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
            //Navigator.of(context).pushNamed(MedicalReportAdd.routeName);
            print('Button pressed');
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
}
