import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/address.dart';
import '../../api_services/customer_service.dart';
import '../../component/alert_dialog.dart';
import '../../component/app_bar.dart';
import '../../core/const/back-end/error_reponse.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'member_address.dart';

class AddressAdd extends StatefulWidget {
  const AddressAdd({super.key});

  static String routeName = '/address_addnew';

  @override
  State<AddressAdd> createState() => _AddressAddState();
}

class _AddressAddState extends State<AddressAdd> {
  List<String> displayName = ['Nhà riêng', 'Công ty', 'Khác'];
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noAddressController = TextEditingController();
  int _selectedName = 0;

  CallCustomerApi api = CallCustomerApi();
  var log = Logger();

  OverlayEntry? _overlayEntry;

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

  bool isEmpty(String noAddress, String address) {
    return noAddress.isEmpty || address.isEmpty;
  }

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

  Future<void> _saveData() async {
    if (userDetails != null) {
      final customerId = userDetails!.id;

      String address = _addressController.text;
      int name = _selectedName;
      String noAddress = _noAddressController.text;

      if (isEmpty(address, noAddress)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: Text(DiaLogMessage.title,
                  style: GoogleFonts.roboto(
                    color: ColorPalette.blueBold2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              message: Text(
                OnInvalidInputMessage.emptyInput,
                style: GoogleFonts.roboto(
                  color: ColorPalette.blueBold2,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
        return;
      }

      String getAddress =
          '${_noAddressController.text}, ${_addressController.text}';

      final newAddress = Address(
        displayName: displayName[name],
        address: getAddress,
        customerId: customerId,
      );

      try {
        _showLoadingOverlay(context);
        bool isSuccess = await api.addNewAddress(newAddress);

        if (isSuccess) {
          //show dialog
          _showSuccessDialog();
        } else {
          _showFailDialog();
        }

        // Clear text controllers
        _addressController.clear();
        _noAddressController.clear();
      } catch (error) {
        log.e('Error adding new address: $error');
      } finally {
        // Ẩn vòng loading khi quá trình đăng nhập hoàn thành
        _hideLoadingOverlay();
      }
    }
  }

  void _showResultDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: Text(title),
          confirmText: "OK",
          message: Text(
            content,
            style: GoogleFonts.roboto(
              color: ColorPalette.blueBold2,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onConfirm: () {
            Navigator.of(context).pushReplacementNamed(MemberAddress.routeName);
          },
        );
      },
    );
  }

  void _showSuccessDialog() {
    _showResultDialog(
        'Thành công', OperationSuccessMessage.createSuccess("đia chỉ"));
  }

  void _showFailDialog() {
    _showResultDialog(
        'Thất bại', 'Thêm mới địa chỉ thất bại! Vui lòng thử lại!');
  }

  @override
  void dispose() {
    _addressController.dispose();
    _noAddressController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
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
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                const Center(
                  child: Icon(
                    Icons.maps_home_work_rounded,
                    size: 100,
                    color: ColorPalette.pink,
                  ),
                ),
                const SizedBox(height: 15),
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
                        setState(() {
                          _selectedName = displayName.indexOf(value);
                        });
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
                      readOnly: true,
                      onTap: () async {
                        LocationData? locationData = await LocationSearch.show(
                          context: context,
                          lightAdress: true,
                          mode: Mode.fullscreen,
                          countryCodes: ['VN'],
                          language: 'vi',
                          searchBarHintText: 'Nhập địa chỉ',
                          searchBarHintColor: ColorPalette.blueBold2,
                          historyMaxLength: 5,
                          searchBarBackgroundColor: ColorPalette.secondaryWhite,
                          loadingWidget: Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: ColorPalette.pinkBold,
                              size: 80,
                            ),
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
                          _addressController.text = locationData?.address ?? '';
                        });
                      },
                      controller: _addressController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Chọn địa chỉ của bạn',
                        hintStyle: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                        ),
                        filled: true,
                        fillColor: ColorPalette.secondaryWhite,
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.grey2, width: 1.0),
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
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _noAddressController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Số nhà, tên toà nhà, ...',
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
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        (_noAddressController.text + _addressController.text)
                                .isEmpty
                            ? 'Xem trước địa chỉ của bạn'
                            : '${_noAddressController.text}, ${_addressController.text}',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: ElevatedButton(
            onPressed: () {
              _saveData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPalette.pink,
              padding: const EdgeInsets.all(12),
              minimumSize: const Size(100, 40),
            ),
            child: Text(
              'Tạo ',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorPalette.secondaryWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
